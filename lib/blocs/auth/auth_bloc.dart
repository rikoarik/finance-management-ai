import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;
  StreamSubscription<User?>? _authStateSubscription;

  AuthBloc({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(const AuthState.initial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<SignIn>(_onSignIn);
    on<SignUp>(_onSignUp);
    on<SignOut>(_onSignOut);
    on<ResetPassword>(_onResetPassword);

    // Listen to auth state changes
    _authStateSubscription = _firebaseAuth.authStateChanges().listen(
      (user) {
        if (user != null) {
          add(const CheckAuthStatus());
        } else {
          // ignore: invalid_use_of_visible_for_testing_member
          emit(const AuthState.unauthenticated());
        }
      },
    );
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      emit(AuthState.authenticated(user: user));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onSignIn(
    SignIn event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthState.loading());
      
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      if (userCredential.user != null) {
        emit(AuthState.authenticated(user: userCredential.user!));
      }
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';
      
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found with this email';
          break;
        case 'wrong-password':
          message = 'Wrong password';
          break;
        case 'invalid-email':
          message = 'Invalid email address';
          break;
        case 'user-disabled':
          message = 'This user has been disabled';
          break;
        case 'too-many-requests':
          message = 'Too many login attempts. Please try again later';
          break;
        default:
          message = e.message ?? 'Authentication failed';
      }
      
      emit(AuthState.error(message: message));
      emit(const AuthState.unauthenticated());
    } catch (e) {
      emit(AuthState.error(message: e.toString()));
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onSignUp(
    SignUp event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthState.loading());
      
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      // Update display name
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(event.name);
        await userCredential.user!.reload();
        
        final updatedUser = _firebaseAuth.currentUser;
        if (updatedUser != null) {
          emit(AuthState.authenticated(user: updatedUser));
        }
      }
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';
      
      switch (e.code) {
        case 'weak-password':
          message = 'Password is too weak';
          break;
        case 'email-already-in-use':
          message = 'An account already exists with this email';
          break;
        case 'invalid-email':
          message = 'Invalid email address';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled';
          break;
        default:
          message = e.message ?? 'Registration failed';
      }
      
      emit(AuthState.error(message: message));
      emit(const AuthState.unauthenticated());
    } catch (e) {
      emit(AuthState.error(message: e.toString()));
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onSignOut(
    SignOut event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthState.loading());
      await _firebaseAuth.signOut();
      emit(const AuthState.unauthenticated());
    } catch (e) {
      emit(AuthState.error(message: e.toString()));
    }
  }

  Future<void> _onResetPassword(
    ResetPassword event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: event.email);
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';
      
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found with this email';
          break;
        case 'invalid-email':
          message = 'Invalid email address';
          break;
        default:
          message = e.message ?? 'Failed to send reset email';
      }
      
      emit(AuthState.error(message: message));
    } catch (e) {
      emit(AuthState.error(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}

