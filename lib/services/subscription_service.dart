import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:device_info_plus/device_info_plus.dart';

/// Subscription type enum
enum SubscriptionType {
  trial,
  proMonthly,
  proUnlimited,
}

extension SubscriptionTypeExtension on SubscriptionType {
  String get value {
    switch (this) {
      case SubscriptionType.trial:
        return 'trial';
      case SubscriptionType.proMonthly:
        return 'pro_monthly';
      case SubscriptionType.proUnlimited:
        return 'pro_unlimited';
    }
  }

  static SubscriptionType? fromString(String? value) {
    switch (value) {
      case 'trial':
        return SubscriptionType.trial;
      case 'pro_monthly':
        return SubscriptionType.proMonthly;
      case 'pro_unlimited':
        return SubscriptionType.proUnlimited;
      default:
        return null;
    }
  }
}

class SubscriptionService {
  static final SubscriptionService _instance = SubscriptionService._internal();
  factory SubscriptionService() => _instance;
  SubscriptionService._internal();

  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  /// Check if user has active trial
  Future<bool> isTrialActive(String userId) async {
    try {
      final snapshot = await _database
          .child('users')
          .child(userId)
          .child('subscription')
          .child('trial_end_date')
          .get();

      if (snapshot.exists && snapshot.value != null) {
        final trialEndTimestamp = snapshot.value as int;
        final trialEndDate = DateTime.fromMillisecondsSinceEpoch(trialEndTimestamp);
        return DateTime.now().isBefore(trialEndDate);
      }
      
      return false;
    } catch (e) {
      print('Error checking trial status: $e');
      return false;
    }
  }

  /// Check if user is premium
  Future<bool> isPremium(String userId) async {
    try {
      final snapshot = await _database
          .child('users')
          .child(userId)
          .child('subscription')
          .child('is_premium')
          .get();

      if (snapshot.exists && snapshot.value != null) {
        return snapshot.value as bool;
      }
      
      return false;
    } catch (e) {
      print('Error checking premium status: $e');
      return false;
    }
  }

  /// Check if user can use AI (trial active, premium, or unlimited)
  Future<bool> canUseAI(String userId) async {
    // Check unlimited first (highest priority)
    final unlimited = await isUnlimited(userId);
    if (unlimited) return true;
    
    // Check premium
    final premium = await isPremium(userId);
    if (premium) return true;
    
    // Check trial
    return await isTrialActive(userId);
  }

  /// Start trial for user (14 days)
  /// Also saves device ID to prevent abuse
  Future<void> startTrial(String userId, String deviceId) async {
    try {
      final now = DateTime.now();
      final trialEndDate = now.add(const Duration(days: 14));
      
      // Save user trial
      await _database
          .child('users')
          .child(userId)
          .child('subscription')
          .update({
        'trial_start_date': now.millisecondsSinceEpoch,
        'trial_end_date': trialEndDate.millisecondsSinceEpoch,
        'is_premium': false,
        'subscription_type': SubscriptionType.trial.value,
      });

      // Save device trial to prevent abuse
      await saveDeviceIdTrial(deviceId, userId);
    } catch (e) {
      throw Exception('Failed to start trial: $e');
    }
  }

  /// Get remaining trial days
  Future<int?> getRemainingTrialDays(String userId) async {
    try {
      final snapshot = await _database
          .child('users')
          .child(userId)
          .child('subscription')
          .child('trial_end_date')
          .get();

      if (snapshot.exists && snapshot.value != null) {
        final trialEndTimestamp = snapshot.value as int;
        final trialEndDate = DateTime.fromMillisecondsSinceEpoch(trialEndTimestamp);
        final now = DateTime.now();
        
        if (now.isBefore(trialEndDate)) {
          return trialEndDate.difference(now).inDays;
        }
      }
      
      return null;
    } catch (e) {
      print('Error getting remaining trial days: $e');
      return null;
    }
  }

  /// Set premium status (for admin)
  /// Also updates subscription_type for backward compatibility
  Future<void> setPremium(String userId, bool isPremium) async {
    try {
      final updates = <String, dynamic>{
        'is_premium': isPremium,
      };
      
      // Update subscription_type for backward compatibility
      if (isPremium) {
        // If setting premium, default to pro_monthly if no subscription_type exists
        final currentType = await getSubscriptionType(userId);
        if (currentType == null) {
          updates['subscription_type'] = SubscriptionType.proMonthly.value;
        }
      }
      
      await _database
          .child('users')
          .child(userId)
          .child('subscription')
          .update(updates);
    } catch (e) {
      throw Exception('Failed to set premium status: $e');
    }
  }

  /// Get subscription type for user
  Future<SubscriptionType?> getSubscriptionType(String userId) async {
    try {
      final snapshot = await _database
          .child('users')
          .child(userId)
          .child('subscription')
          .child('subscription_type')
          .get();

      if (snapshot.exists && snapshot.value != null) {
        final typeString = snapshot.value as String;
        return SubscriptionTypeExtension.fromString(typeString);
      }
      
      return null;
    } catch (e) {
      print('Error getting subscription type: $e');
      return null;
    }
  }

  /// Set subscription type (for admin)
  /// subscriptionType can be: 'trial', 'pro_monthly', 'pro_unlimited'
  Future<void> setSubscriptionType(String userId, SubscriptionType subscriptionType) async {
    try {
      final updates = <String, dynamic>{
        'subscription_type': subscriptionType.value,
      };
      
      // Auto-update is_premium based on subscription type
      if (subscriptionType == SubscriptionType.proMonthly || 
          subscriptionType == SubscriptionType.proUnlimited) {
        updates['is_premium'] = true;
      } else if (subscriptionType == SubscriptionType.trial) {
        updates['is_premium'] = false;
      }
      
      await _database
          .child('users')
          .child(userId)
          .child('subscription')
          .update(updates);
    } catch (e) {
      throw Exception('Failed to set subscription type: $e');
    }
  }

  /// Check if user has unlimited access
  Future<bool> isUnlimited(String userId) async {
    try {
      final snapshot = await _database
          .child('users')
          .child(userId)
          .child('subscription')
          .child('is_unlimited')
          .get();

      if (snapshot.exists && snapshot.value != null) {
        return snapshot.value as bool;
      }
      
      // Also check if subscription_type is pro_unlimited
      final subscriptionType = await getSubscriptionType(userId);
      if (subscriptionType == SubscriptionType.proUnlimited) {
        return true;
      }
      
      return false;
    } catch (e) {
      print('Error checking unlimited status: $e');
      return false;
    }
  }

  /// Set unlimited status (for admin)
  Future<void> setUnlimited(String userId, bool isUnlimited) async {
    try {
      final updates = <String, dynamic>{
        'is_unlimited': isUnlimited,
      };
      
      // Auto-update subscription_type if setting unlimited
      if (isUnlimited) {
        updates['subscription_type'] = SubscriptionType.proUnlimited.value;
        updates['is_premium'] = true;
      } else {
        // If removing unlimited, check current subscription type
        final currentType = await getSubscriptionType(userId);
        if (currentType == SubscriptionType.proUnlimited) {
          // Change to pro_monthly if was unlimited
          updates['subscription_type'] = SubscriptionType.proMonthly.value;
        }
      }
      
      await _database
          .child('users')
          .child(userId)
          .child('subscription')
          .update(updates);
    } catch (e) {
      throw Exception('Failed to set unlimited status: $e');
    }
  }

  /// Check if user has skipped trial
  Future<bool> hasSkippedTrial(String userId) async {
    try {
      final snapshot = await _database
          .child('users')
          .child(userId)
          .child('subscription')
          .child('skip_trial')
          .get();

      if (snapshot.exists && snapshot.value != null) {
        return snapshot.value as bool;
      }
      
      return false;
    } catch (e) {
      print('Error checking skip trial status: $e');
      return false;
    }
  }

  /// Set skip trial status (for admin)
  /// If true, user will not be offered trial
  Future<void> setSkipTrial(String userId, bool skipTrial) async {
    try {
      await _database
          .child('users')
          .child(userId)
          .child('subscription')
          .child('skip_trial')
          .set(skipTrial);
    } catch (e) {
      throw Exception('Failed to set skip trial status: $e');
    }
  }

  /// Get device ID (stable identifier for the device)
  Future<String> getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        return androidInfo.id; // Android ID (stable per device)
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? 'ios-unknown';
      } else if (Platform.isWindows) {
        final windowsInfo = await _deviceInfo.windowsInfo;
        return windowsInfo.deviceId.isNotEmpty ? windowsInfo.deviceId : 'windows-unknown';
      } else if (Platform.isMacOS) {
        final macInfo = await _deviceInfo.macOsInfo;
        return macInfo.systemGUID?.isNotEmpty == true ? macInfo.systemGUID! : 'macos-unknown';
      } else if (Platform.isLinux) {
        final linuxInfo = await _deviceInfo.linuxInfo;
        return linuxInfo.machineId ?? 'linux-unknown';
      }
      return 'unknown-platform';
    } catch (e) {
      print('Error getting device ID: $e');
      // Fallback to a generated UUID or timestamp-based ID
      return 'device-${DateTime.now().millisecondsSinceEpoch}';
    }
  }

  /// Check if device has already used trial
  Future<bool> hasDeviceUsedTrial(String deviceId) async {
    try {
      final snapshot = await _database
          .child('device_trials')
          .child(deviceId)
          .get();

      if (!snapshot.exists) {
        return false;
      }

      // Check if trial exists (device has used trial before)
      final data = snapshot.value as Map<dynamic, dynamic>?;
      if (data == null) return false;

      final trialEndDate = data['trial_end_date'];
      if (trialEndDate == null) return false;

      // Device has used trial (regardless of active/expired)
      return true;
    } catch (e) {
      print('Error checking device trial: $e');
      return false; // On error, allow trial (fail open)
    }
  }

  /// Save device ID to Firebase when trial starts
  Future<void> saveDeviceIdTrial(String deviceId, String userId) async {
    try {
      final now = DateTime.now();
      final trialEndDate = now.add(const Duration(days: 14));

      await _database
          .child('device_trials')
          .child(deviceId)
          .update({
        'userId': userId,
        'trial_start_date': now.millisecondsSinceEpoch,
        'trial_end_date': trialEndDate.millisecondsSinceEpoch,
      });
    } catch (e) {
      throw Exception('Failed to save device trial: $e');
    }
  }

  /// Check if user can start trial (validate device ID)
  Future<bool> canStartTrial(String userId, String deviceId) async {
    try {
      // Check if device already used trial
      final deviceUsedTrial = await hasDeviceUsedTrial(deviceId);
      if (deviceUsedTrial) {
        return false;
      }

      // Check if user already has trial
      final userTrialActive = await isTrialActive(userId);
      if (userTrialActive) {
        return false; // User already has active trial
      }

      return true;
    } catch (e) {
      print('Error checking if can start trial: $e');
      return false; // On error, don't allow trial
    }
  }

  /// Check if user is new (no trial_start_date)
  Future<bool> isNewUser(String userId) async {
    try {
      final snapshot = await _database
          .child('users')
          .child(userId)
          .child('subscription')
          .child('trial_start_date')
          .get();

      return !snapshot.exists || snapshot.value == null;
    } catch (e) {
      print('Error checking if new user: $e');
      return false;
    }
  }
}

