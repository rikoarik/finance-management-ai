import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.checkAuthStatus() = CheckAuthStatus;
  const factory AuthEvent.signIn({
    required String email,
    required String password,
  }) = SignIn;
  const factory AuthEvent.signUp({
    required String email,
    required String password,
    required String name,
  }) = SignUp;
  const factory AuthEvent.signOut() = SignOut;
  const factory AuthEvent.resetPassword({required String email}) = ResetPassword;
}

