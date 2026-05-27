part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final TextEditingController loginEmailController;
  final TextEditingController loginPasswordController;
  final bool isLoginLoading;
  final bool isPasswordVisible;
  final TextEditingController signupFullNameController;
  final TextEditingController signupEmailController;
  final TextEditingController signupPasswordController;
  final TextEditingController signupConfirmPasswordController;
  final bool isSignupLoading;
  final bool isSignupPasswordVisible;
  final bool isSignupConfirmPasswordVisible;
  final TextEditingController forgotPasswordEmailController;
  final bool isForgotPasswordLoading;
  final TextEditingController otpController;
  final bool isResendOtpLoading;
  final bool isVerifyOtpLoading;
  final TextEditingController verifyOTPController;
  final bool isVerifyEmailLoading;
  final bool isVerifyEmailResendLoading;
  final TextEditingController resetPasswordController;
  final bool isResetPasswordLoading;
  final bool isResetPasswordVisible;
  final String? signupErrorMessage;
  final String? loginErrorMessage;
  final String? forgotPasswordErrorMessage;
  final String? verifyEmailErrorMessage;
  final String? verifyOtpErrorMessage;
  final String? resetPasswordErrorMessage;
  final bool isGoogleSignInLoading;
  final String? googleSignInErrorMessage;
  final bool isAppleSignInLoading;
  final String? appleSignInErrorMessage;
  final bool isPrivacyPolicyAccepted;
  final bool shouldShakePrivacyPolicy;

  const AuthState({
    required this.loginEmailController,
    required this.loginPasswordController,
    required this.isLoginLoading,
    required this.isPasswordVisible,
    required this.signupFullNameController,
    required this.signupEmailController,
    required this.signupPasswordController,
    required this.signupConfirmPasswordController,
    this.isSignupLoading = false,
    this.isSignupPasswordVisible = false,
    this.isSignupConfirmPasswordVisible = false,
    required this.forgotPasswordEmailController,
    this.isForgotPasswordLoading = false,
    required this.otpController,
    this.isResendOtpLoading = false,
    this.isVerifyOtpLoading = false,
    required this.verifyOTPController,
    this.isVerifyEmailLoading = false,
    this.isVerifyEmailResendLoading = false,
    required this.resetPasswordController,
    this.isResetPasswordLoading = false,
    this.isResetPasswordVisible = false,
    this.signupErrorMessage,
    this.loginErrorMessage,
    this.forgotPasswordErrorMessage,
    this.verifyEmailErrorMessage,
    this.verifyOtpErrorMessage,
    this.resetPasswordErrorMessage,
    this.isGoogleSignInLoading = false,
    this.googleSignInErrorMessage,
    this.isAppleSignInLoading = false,
    this.appleSignInErrorMessage,
    this.isPrivacyPolicyAccepted = false,
    this.shouldShakePrivacyPolicy = false,
  });

  factory AuthState.initial() {
    return AuthState(
      loginEmailController: TextEditingController(text: ""),
      loginPasswordController: TextEditingController(text: ""),
      isLoginLoading: false,
      isPasswordVisible: false,
      signupFullNameController: TextEditingController(text: ""),
      signupEmailController: TextEditingController(text: ""),
      signupPasswordController: TextEditingController(text: ""),
      signupConfirmPasswordController: TextEditingController(text: ""),
      forgotPasswordEmailController: TextEditingController(text: ""),
      otpController: TextEditingController(text: ""),
      verifyOTPController: TextEditingController(text: ""),
      resetPasswordController: TextEditingController(text: ""),
      shouldShakePrivacyPolicy: false,
    );
  }

  @override
  List<Object?> get props => [
    loginEmailController,
    loginPasswordController,
    isLoginLoading,
    isPasswordVisible,
    signupFullNameController,
    signupEmailController,
    signupPasswordController,
    signupConfirmPasswordController,
    isSignupLoading,
    isSignupPasswordVisible,
    isSignupConfirmPasswordVisible,
    forgotPasswordEmailController,
    isForgotPasswordLoading,
    otpController,
    isResendOtpLoading,
    isVerifyOtpLoading,
    verifyOTPController,
    isVerifyEmailLoading,
    isVerifyEmailResendLoading,
    resetPasswordController,
    isResetPasswordLoading,
    isResetPasswordVisible,
    signupErrorMessage,
    loginErrorMessage,
    forgotPasswordErrorMessage,
    verifyEmailErrorMessage,
    verifyOtpErrorMessage,
    resetPasswordErrorMessage,
    isGoogleSignInLoading,
    googleSignInErrorMessage,
    isAppleSignInLoading,
    appleSignInErrorMessage,
    isPrivacyPolicyAccepted,
    shouldShakePrivacyPolicy,
  ];

  AuthState copyWith({
    TextEditingController? loginEmailController,
    TextEditingController? loginPasswordController,
    bool? isLoginLoading,
    bool? isPasswordVisible,
    TextEditingController? signupFullNameController,
    TextEditingController? signupEmailController,
    TextEditingController? signupPasswordController,
    TextEditingController? signupConfirmPasswordController,
    bool? isSignupLoading,
    bool? isSignupPasswordVisible,
    bool? isSignupConfirmPasswordVisible,
    TextEditingController? forgotPasswordEmailController,
    bool? isForgotPasswordLoading,
    TextEditingController? otpController,
    bool? isResendOtpLoading,
    bool? isVerifyOtpLoading,
    TextEditingController? verifyOTPController,
    bool? isVerifyEmailLoading,
    bool? isVerifyEmailResendLoading,
    TextEditingController? resetPasswordController,
    bool? isResetPasswordLoading,
    bool? isResetPasswordVisible,
    String? signupErrorMessage,
    String? loginErrorMessage,
    String? forgotPasswordErrorMessage,
    String? verifyEmailErrorMessage,
    String? verifyOtpErrorMessage,
    String? resetPasswordErrorMessage,
    bool? isGoogleSignInLoading,
    String? googleSignInErrorMessage,
    bool? isAppleSignInLoading,
    String? appleSignInErrorMessage,
    bool? isPrivacyPolicyAccepted,
    bool? shouldShakePrivacyPolicy,
  }) {
    return AuthState(
      loginEmailController: loginEmailController ?? this.loginEmailController,
      loginPasswordController: loginPasswordController ?? this.loginPasswordController,
      isLoginLoading: isLoginLoading ?? this.isLoginLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      signupFullNameController: signupFullNameController ?? this.signupFullNameController,
      signupEmailController: signupEmailController ?? this.signupEmailController,
      signupPasswordController: signupPasswordController ?? this.signupPasswordController,
      signupConfirmPasswordController: signupConfirmPasswordController ?? this.signupConfirmPasswordController,
      isSignupLoading: isSignupLoading ?? this.isSignupLoading,
      isSignupPasswordVisible: isSignupPasswordVisible ?? this.isSignupPasswordVisible,
      isSignupConfirmPasswordVisible: isSignupConfirmPasswordVisible ?? this.isSignupConfirmPasswordVisible,
      forgotPasswordEmailController: forgotPasswordEmailController ?? this.forgotPasswordEmailController,
      isForgotPasswordLoading: isForgotPasswordLoading ?? this.isForgotPasswordLoading,
      otpController: otpController ?? this.otpController,
      isResendOtpLoading: isResendOtpLoading ?? this.isResendOtpLoading,
      isVerifyOtpLoading: isVerifyOtpLoading ?? this.isVerifyOtpLoading,
      verifyOTPController: verifyOTPController ?? this.verifyOTPController,
      isVerifyEmailLoading: isVerifyEmailLoading ?? this.isVerifyEmailLoading,
      isVerifyEmailResendLoading: isVerifyEmailResendLoading ?? this.isVerifyEmailResendLoading,
      resetPasswordController: resetPasswordController ?? this.resetPasswordController,
      isResetPasswordLoading: isResetPasswordLoading ?? this.isResetPasswordLoading,
      isResetPasswordVisible: isResetPasswordVisible ?? this.isResetPasswordVisible,
      signupErrorMessage: signupErrorMessage ?? this.signupErrorMessage,
      loginErrorMessage: loginErrorMessage ?? this.loginErrorMessage,
      forgotPasswordErrorMessage: forgotPasswordErrorMessage ?? this.forgotPasswordErrorMessage,
      verifyEmailErrorMessage: verifyEmailErrorMessage ?? this.verifyEmailErrorMessage,
      verifyOtpErrorMessage: verifyOtpErrorMessage ?? this.verifyOtpErrorMessage,
      resetPasswordErrorMessage: resetPasswordErrorMessage ?? this.resetPasswordErrorMessage,
      isGoogleSignInLoading: isGoogleSignInLoading ?? this.isGoogleSignInLoading,
      googleSignInErrorMessage: googleSignInErrorMessage ?? this.googleSignInErrorMessage,
      isAppleSignInLoading: isAppleSignInLoading ?? this.isAppleSignInLoading,
      appleSignInErrorMessage: appleSignInErrorMessage ?? this.appleSignInErrorMessage,
      isPrivacyPolicyAccepted: isPrivacyPolicyAccepted ?? this.isPrivacyPolicyAccepted,
      shouldShakePrivacyPolicy: shouldShakePrivacyPolicy ?? this.shouldShakePrivacyPolicy,
    );
  }
}
