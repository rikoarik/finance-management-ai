import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_state.freezed.dart';

@freezed
class ThemeState with _$ThemeState {
  const ThemeState._();
  
  const factory ThemeState({
    @Default(ThemeMode.system) ThemeMode themeMode,
  }) = _ThemeState;

  factory ThemeState.fromJson(Map<String, dynamic> json) {
    final modeString = json['themeMode'] as String?;
    ThemeMode mode = ThemeMode.system;
    
    if (modeString == 'light') {
      mode = ThemeMode.light;
    } else if (modeString == 'dark') {
      mode = ThemeMode.dark;
    }
    
    return ThemeState(themeMode: mode);
  }

  Map<String, dynamic> toJson() {
    String modeString = 'system';
    if (themeMode == ThemeMode.light) {
      modeString = 'light';
    } else if (themeMode == ThemeMode.dark) {
      modeString = 'dark';
    }
    
    return {'themeMode': modeString};
  }
}

