part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class TogglePasswordVisibilityEvent extends AuthEvent {
  const TogglePasswordVisibilityEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class ToggleSignupPasswordVisibilityEvent extends AuthEvent {
  const ToggleSignupPasswordVisibilityEvent();

  @override
  List<Object> get props => [];
}

class ToggleSignupConfirmPasswordVisibilityEvent extends AuthEvent {
  const ToggleSignupConfirmPasswordVisibilityEvent();

  @override
  List<Object> get props => [];
}

class SignupEvent extends AuthEvent {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordEvent extends AuthEvent {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class VerifyOtpSubmittedEvent extends AuthEvent {
  final String email;
  final String otp;
  final String fullName;
  final String password;

  const VerifyOtpSubmittedEvent({
    required this.email,
    required this.otp,
    required this.fullName,
    required this.password,
  });

  @override
  List<Object> get props => [email, otp, fullName, password];
}

class OtpResendRequested extends AuthEvent {
  final String email;
  const OtpResendRequested({required this.email});
  @override
  List<Object> get props => [email];
}

class VerifyEmailSubmittedEvent extends AuthEvent {
  final String email;
  final String otp;
  const VerifyEmailSubmittedEvent({required this.email, required this.otp});
  @override
  List<Object> get props => [email, otp];
}

class VerifyEmailResendRequested extends AuthEvent {
  const VerifyEmailResendRequested();
  @override
  List<Object> get props => [];
}

class ToggleResetPasswordVisibilityEvent extends AuthEvent {
  const ToggleResetPasswordVisibilityEvent();
  @override
  List<Object> get props => [];
}

class ResetPasswordEvent extends AuthEvent {
  const ResetPasswordEvent();
  @override
  List<Object> get props => [];
}

class ClearSignupMessagesEvent extends AuthEvent {
  const ClearSignupMessagesEvent();
  @override
  List<Object> get props => [];
}

class InitializeSignupFormEvent extends AuthEvent {
  const InitializeSignupFormEvent();
  @override
  List<Object> get props => [];
}

class ClearLoginMessagesEvent extends AuthEvent {
  const ClearLoginMessagesEvent();
  @override
  List<Object> get props => [];
}

class ClearForgotPasswordMessagesEvent extends AuthEvent {
  const ClearForgotPasswordMessagesEvent();
  @override
  List<Object> get props => [];
}

class ClearVerifyEmailMessagesEvent extends AuthEvent {
  const ClearVerifyEmailMessagesEvent();
  @override
  List<Object> get props => [];
}

class ClearResetPasswordMessagesEvent extends AuthEvent {
  const ClearResetPasswordMessagesEvent();
  @override
  List<Object> get props => [];
}

class GoogleSignInEvent extends AuthEvent {
  const GoogleSignInEvent();
  @override
  List<Object> get props => [];
}

class AppleSignInEvent extends AuthEvent {
  const AppleSignInEvent();
  @override
  List<Object> get props => [];
}

class ClearGoogleSignInMessagesEvent extends AuthEvent {
  const ClearGoogleSignInMessagesEvent();
  @override
  List<Object> get props => [];
}

class ClearAppleSignInMessagesEvent extends AuthEvent {
  const ClearAppleSignInMessagesEvent();
  @override
  List<Object> get props => [];
}

class TogglePrivacyPolicyEvent extends AuthEvent {
  const TogglePrivacyPolicyEvent();
  @override
  List<Object> get props => [];
}

class ResetDataEvent extends AuthEvent {
  const ResetDataEvent();
  @override
  List<Object> get props => [];
}

class TriggerPrivacyPolicyShakeEvent extends AuthEvent {
  const TriggerPrivacyPolicyShakeEvent();
  @override
  List<Object> get props => [];
}
