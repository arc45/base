import 'package:caloriex/core/errors/handle_error.dart';
import 'package:caloriex/core/utils/app_exports.dart';
import 'package:caloriex/repository/auth_repository.dart';
import 'package:caloriex/services/apple_signin_service.dart';
import 'package:caloriex/services/google_sign_in_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthState.initial()) {
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
    on<LoginEvent>(_onLogin);
    on<ToggleSignupPasswordVisibilityEvent>(_onToggleSignupPasswordVisibilityEvent);
    on<ToggleSignupConfirmPasswordVisibilityEvent>(_onToggleSignupConfirmPasswordVisibilityEvent);
    on<SignupEvent>(_onSignup);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<OtpResendRequested>(_onOtpResendRequested);
    on<VerifyOtpSubmittedEvent>(_onVerifyOtpSubmittedEvent);
    on<VerifyEmailSubmittedEvent>(_onVerifyEmailSubmittedEvent);
    on<VerifyEmailResendRequested>(_onVerifyEmailResendRequested);
    on<ResetPasswordEvent>(_onResetPasswordEvent);
    on<ToggleResetPasswordVisibilityEvent>(_onToggleResetPasswordVisibilityEvent);
    on<ClearSignupMessagesEvent>(_onClearSignupMessages);
    on<InitializeSignupFormEvent>(_onInitializeSignupForm);
    on<ClearLoginMessagesEvent>(_onClearLoginMessages);
    on<ClearForgotPasswordMessagesEvent>(_onClearForgotPasswordMessages);
    on<ClearVerifyEmailMessagesEvent>(_onClearVerifyEmailMessages);
    on<ClearResetPasswordMessagesEvent>(_onClearResetPasswordMessages);
    on<GoogleSignInEvent>(_onGoogleSignIn);
    on<AppleSignInEvent>(_onAppleSignIn);
    on<ClearGoogleSignInMessagesEvent>(_onClearGoogleSignInMessages);
    on<ClearAppleSignInMessagesEvent>(_onClearAppleSignInMessages);
    on<TogglePrivacyPolicyEvent>(_onTogglePrivacyPolicy);
    on<ResetDataEvent>(_onResetData);
    on<TriggerPrivacyPolicyShakeEvent>(_onTriggerPrivacyPolicyShake);
  }

  Future<void> _onInitializeSignupForm(InitializeSignupFormEvent event, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        signupFullNameController: TextEditingController(),
        signupEmailController: TextEditingController(),
        signupPasswordController: TextEditingController(),
        signupConfirmPasswordController: TextEditingController(),
      ),
    );
  }

  Future<void> _onTogglePasswordVisibility(TogglePasswordVisibilityEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> _onToggleSignupPasswordVisibilityEvent(
    ToggleSignupPasswordVisibilityEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isSignupPasswordVisible: !state.isSignupPasswordVisible));
  }

  Future<void> _onToggleSignupConfirmPasswordVisibilityEvent(
    ToggleSignupConfirmPasswordVisibilityEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isSignupConfirmPasswordVisible: !state.isSignupConfirmPasswordVisible));
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoginLoading: true, loginErrorMessage: ''));

    try {
      final response = await authRepository.loginApiCall(
        email: state.loginEmailController.text,
        password: state.loginPasswordController.text,
      );

      emit(state.copyWith(isLoginLoading: false));

      if (response.accessToken != null && response.accessToken!.isNotEmpty) {
        await Prefobj.preferences?.put(Prefkeys.AUTHTOKEN, response.accessToken!);
      }
      if (response.refreshToken != null && response.refreshToken!.isNotEmpty) {
        await Prefobj.preferences?.put(Prefkeys.REFRESHTOKEN, response.refreshToken!);
      }
      await Prefobj.preferences?.put(Prefkeys.ISPERSONALDETAILCOMPLETED, response.user?.onboardingCompleted ?? false);
      await Prefobj.preferences?.put(Prefkeys.USER_NAME, response.user?.fullName ?? '');

      if (response.user?.onboardingCompleted == true) {
        NavigatorService.pushNamedAndRemoveUntil(AppRoutes.bottomNavigationView);
        NavigatorService.navigatorKey.currentContext!.read<SettingsBloc>().add(LoadUserProfileEvent());
        NavigatorService.navigatorKey.currentContext!.read<HomeBloc>().add(const LoadHomeDataEvent());
      } else {
        NavigatorService.pushNamedAndRemoveUntil(AppRoutes.personalDetailView);
      }
    } catch (error) {
      emit(state.copyWith(isLoginLoading: false, loginErrorMessage: handleError(error)));
      Logger.lOG("Login Error: $error");
    }
  }

  Future<void> _onSignup(SignupEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isSignupLoading: true, signupErrorMessage: ""));

    try {
      final response = await authRepository.registerApiCall(email: state.signupEmailController.text);

      emit(state.copyWith(isSignupLoading: false));

      if (response.sent == true) {
        final fullName = state.signupFullNameController.text;
        if (fullName.isNotEmpty) {
          await Prefobj.preferences?.put(Prefkeys.USER_NAME, fullName);
        }
        NavigatorService.pushNamed(
          AppRoutes.otpVerificationRoute,
          arguments: {
            'email': state.signupEmailController.text,
            'fullName': fullName,
            'password': state.signupPasswordController.text,
          },
        );
      } else {
        emit(state.copyWith(signupErrorMessage: response.message ?? 'Registration failed. Please try again.'));
      }
    } catch (error) {
      emit(state.copyWith(isSignupLoading: false, signupErrorMessage: handleError(error)));
      Logger.lOG("Signup Error: $error");
    }
  }

  Future<void> _onForgotPassword(ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isForgotPasswordLoading: true, forgotPasswordErrorMessage: ''));

    try {
      final response = await authRepository.forgotPasswordApiCall(email: state.forgotPasswordEmailController.text);

      if (response.sent == true) {
        emit(state.copyWith(isForgotPasswordLoading: false));
        NavigatorService.pushNamed(
          AppRoutes.verifyEmailRoute,
          arguments: {'email': state.forgotPasswordEmailController.text},
        );
      } else {
        emit(
          state.copyWith(
            forgotPasswordErrorMessage: response.message ?? 'Failed to send reset code. Please try again.',
          ),
        );
      }
    } catch (error) {
      emit(state.copyWith(isForgotPasswordLoading: false, forgotPasswordErrorMessage: handleError(error)));
      Logger.lOG("Forgot Password Error: $error");
    }
  }

  Future<void> _onOtpResendRequested(OtpResendRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isResendOtpLoading: true, verifyOtpErrorMessage: ""));

    try {
      final response = await authRepository.registerApiCall(email: state.signupEmailController.text);
      if (response.sent == true) {
        emit(state.copyWith(isResendOtpLoading: false, verifyOtpErrorMessage: ""));
      } else {
        emit(state.copyWith(isResendOtpLoading: false, verifyOtpErrorMessage: ""));
      }
    } catch (error) {
      emit(state.copyWith(isResendOtpLoading: false, verifyOtpErrorMessage: handleError(error)));
      Logger.lOG("Dio--- Error: $error");
    }
  }

  void _onVerifyOtpSubmittedEvent(VerifyOtpSubmittedEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isVerifyOtpLoading: true, verifyOtpErrorMessage: ""));
    try {
      final response = await authRepository.verifyOtpApiCall(
        email: event.email,
        otp: event.otp,
        purpose: "register",
        fullName: event.fullName,
        password: event.password,
      );

      emit(state.copyWith(isVerifyOtpLoading: false, verifyOtpErrorMessage: ""));

      if (response.accessToken != null && response.accessToken!.isNotEmpty) {
        await Prefobj.preferences?.put(Prefkeys.AUTHTOKEN, response.accessToken!);
      }
      if (response.refreshToken != null && response.refreshToken!.isNotEmpty) {
        await Prefobj.preferences?.put(Prefkeys.REFRESHTOKEN, response.refreshToken!);
      }
      await Prefobj.preferences?.put(Prefkeys.ISPERSONALDETAILCOMPLETED, response.user?.onboardingCompleted ?? false);
      await Prefobj.preferences?.put(Prefkeys.USER_NAME, response.user?.fullName ?? '');

      if (response.user?.onboardingCompleted == true) {
        NavigatorService.pushNamedAndRemoveUntil(AppRoutes.bottomNavigationView);
        NavigatorService.navigatorKey.currentContext!.read<SettingsBloc>().add(LoadUserProfileEvent());
        NavigatorService.navigatorKey.currentContext!.read<HomeBloc>().add(const LoadHomeDataEvent());
      } else {
        NavigatorService.pushNamedAndRemoveUntil(AppRoutes.personalDetailView);
      }

      add(const ResetDataEvent());
    } catch (error) {
      emit(state.copyWith(isVerifyOtpLoading: false, verifyOtpErrorMessage: handleError(error)));
      Logger.lOG("Verify OTP Error: $error");
    }
  }

  Future<void> _onVerifyEmailSubmittedEvent(VerifyEmailSubmittedEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isVerifyEmailLoading: true, verifyEmailErrorMessage: ''));
    try {
      final response = await authRepository.verifyOtpApiCall(
        email: event.email,
        otp: event.otp,
        purpose: "forgot_password",
        fullName: "",
        password: "",
      );

      if (response.verified == true) {
        emit(state.copyWith(isVerifyEmailLoading: false));
        NavigatorService.pushNamed(AppRoutes.resetPasswordRoute);
      } else {
        emit(state.copyWith(verifyEmailErrorMessage: 'Verification failed. Please try again.'));
      }
    } catch (error) {
      emit(state.copyWith(isVerifyEmailLoading: false, verifyEmailErrorMessage: handleError(error)));
      Logger.lOG("Verify Email Error: $error");
    }
  }

  Future<void> _onVerifyEmailResendRequested(VerifyEmailResendRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isVerifyEmailResendLoading: true));
    try {
      final response = await authRepository.forgotPasswordApiCall(email: state.forgotPasswordEmailController.text);

      if (response.sent == true) {
        emit(state.copyWith(isVerifyEmailResendLoading: false));
      } else {
        emit(
          state.copyWith(verifyEmailErrorMessage: response.message ?? 'Failed to send reset code. Please try again.'),
        );
      }
    } catch (e) {
      emit(state.copyWith(isVerifyEmailResendLoading: false));
      Logger.lOG(e.toString());
    }
  }

  Future<void> _onResetPasswordEvent(ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isResetPasswordLoading: true, resetPasswordErrorMessage: ''));
    try {
      final response = await authRepository.resetPasswordApiCall(
        email: state.forgotPasswordEmailController.text,
        otp: state.verifyOTPController.text,
        newPassword: state.resetPasswordController.text,
      );

      if (response.success == true) {
        emit(state.copyWith(isResetPasswordLoading: false));

        add(const ResetDataEvent());
        NavigatorService.pushNamedAndRemoveUntil(AppRoutes.loginRoute);
      } else {
        emit(
          state.copyWith(
            isResetPasswordLoading: false,
            resetPasswordErrorMessage: response.message ?? 'Password reset failed. Please try again.',
          ),
        );
      }
    } catch (error) {
      emit(state.copyWith(isResetPasswordLoading: false, resetPasswordErrorMessage: handleError(error)));
      Logger.lOG("Reset Password Error: $error");
    }
  }

  Future<void> _onToggleResetPasswordVisibilityEvent(
    ToggleResetPasswordVisibilityEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isResetPasswordVisible: !state.isResetPasswordVisible));
  }

  Future<void> _onClearSignupMessages(ClearSignupMessagesEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(signupErrorMessage: ""));
  }

  Future<void> _onClearLoginMessages(ClearLoginMessagesEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loginErrorMessage: ""));
  }

  Future<void> _onClearForgotPasswordMessages(ClearForgotPasswordMessagesEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(forgotPasswordErrorMessage: ""));
  }

  Future<void> _onClearVerifyEmailMessages(ClearVerifyEmailMessagesEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(verifyEmailErrorMessage: "", verifyOtpErrorMessage: ""));
  }

  Future<void> _onClearResetPasswordMessages(ClearResetPasswordMessagesEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(resetPasswordErrorMessage: ""));
  }

  Future<void> _onResetData(ResetDataEvent event, Emitter<AuthState> emit) async {
    state.loginEmailController.clear();
    state.loginPasswordController.clear();
    state.signupFullNameController.clear();
    state.signupEmailController.clear();
    state.signupPasswordController.clear();
    state.signupConfirmPasswordController.clear();
    state.forgotPasswordEmailController.clear();
    state.otpController.clear();
    state.verifyOTPController.clear();
    state.resetPasswordController.clear();

    emit(state.copyWith(isPrivacyPolicyAccepted: false));
  }

  Future<void> _onGoogleSignIn(GoogleSignInEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isGoogleSignInLoading: true, googleSignInErrorMessage: ''));

    try {
      final googleSignInService = GoogleSignInService();

      final googleSignInResult = await googleSignInService.signInWithGoogle();

      Logger.lOG("Google Sign-In Result: ${googleSignInResult?.toJson()}");

      if (googleSignInResult == null) {
        emit(state.copyWith(isGoogleSignInLoading: false));
        return;
      }

      if (googleSignInResult.accessToken.isEmpty) {
        emit(
          state.copyWith(isGoogleSignInLoading: false, googleSignInErrorMessage: 'Failed to get Google access token'),
        );
        return;
      }

      final response = await authRepository.googleSignInApiCall(
        email: googleSignInResult.email,
        displayName: googleSignInResult.displayName,
        photoUrl: googleSignInResult.photoUrl ?? '',
        accessToken: googleSignInResult.accessToken,
      );

      if (googleSignInResult.displayName.isNotEmpty) {
        await Prefobj.preferences?.put(Prefkeys.USER_NAME, googleSignInResult.displayName);
      }

      emit(state.copyWith(isGoogleSignInLoading: false));

      if (response.accessToken != null && response.accessToken!.isNotEmpty) {
        await Prefobj.preferences?.put(Prefkeys.AUTHTOKEN, response.accessToken!);
      }
      if (response.refreshToken != null && response.refreshToken!.isNotEmpty) {
        await Prefobj.preferences?.put(Prefkeys.REFRESHTOKEN, response.refreshToken!);
      }
      await Prefobj.preferences?.put(Prefkeys.ISPERSONALDETAILCOMPLETED, response.user?.onboardingCompleted ?? false);
      await Prefobj.preferences?.put(Prefkeys.USER_NAME, response.user?.fullName ?? '');

      if (response.user?.onboardingCompleted == true) {
        NavigatorService.pushNamedAndRemoveUntil(AppRoutes.bottomNavigationView);
        NavigatorService.navigatorKey.currentContext!.read<SettingsBloc>().add(const LoadUserProfileEvent());
        NavigatorService.navigatorKey.currentContext!.read<HomeBloc>().add(const LoadHomeDataEvent());
      } else {
        NavigatorService.pushNamedAndRemoveUntil(AppRoutes.personalDetailView);
      }

      add(const ResetDataEvent());
    } catch (error) {
      Logger.lOG('Google Sign-In error: $error');
      emit(state.copyWith(isGoogleSignInLoading: false, googleSignInErrorMessage: handleError(error)));
    }
  }

  Future<void> _onAppleSignIn(AppleSignInEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isAppleSignInLoading: true, appleSignInErrorMessage: ''));

    try {
      final appleSignInService = AppleSignInService();

      final appleSignInResult = await appleSignInService.signInWithApple();

      Logger.lOG("Apple Sign-In Result: ${appleSignInResult?.toJson()}");

      if (appleSignInResult == null) {
        emit(state.copyWith(isAppleSignInLoading: false));
        return;
      }

      final response = await authRepository.appleSignInApiCall(
        email: appleSignInResult.email,
        displayName: appleSignInResult.displayName,
        identityToken: appleSignInResult.identityToken,
        userIdentifier: appleSignInResult.userIdentifier,
      );

      if (appleSignInResult.displayName.isNotEmpty) {
        await Prefobj.preferences?.put(Prefkeys.USER_NAME, appleSignInResult.displayName);
      }

      emit(state.copyWith(isAppleSignInLoading: false));

      if (response.accessToken != null && response.accessToken!.isNotEmpty) {
        await Prefobj.preferences?.put(Prefkeys.AUTHTOKEN, response.accessToken!);
      }
      if (response.refreshToken != null && response.refreshToken!.isNotEmpty) {
        await Prefobj.preferences?.put(Prefkeys.REFRESHTOKEN, response.refreshToken!);
      }
      await Prefobj.preferences?.put(Prefkeys.ISPERSONALDETAILCOMPLETED, response.user?.onboardingCompleted ?? false);
      await Prefobj.preferences?.put(Prefkeys.USER_NAME, response.user?.fullName ?? '');

      if (response.user?.onboardingCompleted == true) {
        NavigatorService.pushNamedAndRemoveUntil(AppRoutes.bottomNavigationView);
        NavigatorService.navigatorKey.currentContext!.read<SettingsBloc>().add(const LoadUserProfileEvent());
        NavigatorService.navigatorKey.currentContext!.read<HomeBloc>().add(const LoadHomeDataEvent());
      } else {
        NavigatorService.pushNamedAndRemoveUntil(AppRoutes.personalDetailView);
      }

      add(const ResetDataEvent());
    } catch (error) {
      Logger.lOG('Apple Sign-In error: $error');
      emit(state.copyWith(isAppleSignInLoading: false, appleSignInErrorMessage: handleError(error)));
    }
  }

  Future<void> _onClearGoogleSignInMessages(ClearGoogleSignInMessagesEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(googleSignInErrorMessage: ""));
  }

  Future<void> _onClearAppleSignInMessages(ClearAppleSignInMessagesEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(appleSignInErrorMessage: ""));
  }

  Future<void> _onTogglePrivacyPolicy(TogglePrivacyPolicyEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isPrivacyPolicyAccepted: !state.isPrivacyPolicyAccepted));
  }

  Future<void> _onTriggerPrivacyPolicyShake(TriggerPrivacyPolicyShakeEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(shouldShakePrivacyPolicy: true));
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(shouldShakePrivacyPolicy: false));
  }

  @override
  Future<void> close() {
    state.loginEmailController.dispose();
    state.loginPasswordController.dispose();
    state.signupFullNameController.dispose();
    state.signupEmailController.dispose();
    state.signupPasswordController.dispose();
    state.signupConfirmPasswordController.dispose();
    state.forgotPasswordEmailController.dispose();
    state.otpController.dispose();
    state.verifyOTPController.dispose();
    state.resetPasswordController.dispose();
    return super.close();
  }
}
