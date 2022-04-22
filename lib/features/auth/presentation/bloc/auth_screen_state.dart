import '../../../../core/components/input/custom_input.dart';

class AuthScreenState {
  CustomInputColorModel userInputModel;
  bool isLoginSuccess;
  bool hasError;
  bool isLoading;

  AuthScreenState({
    required this.userInputModel,
    required this.isLoginSuccess,
    required this.hasError,
    required this.isLoading,
  });

  factory AuthScreenState.initial() => AuthScreenState(
        userInputModel: CustomInputColorModel(),
        isLoginSuccess: false,
        hasError: false,
        isLoading: false,
      );

  AuthScreenState copyWith({
    CustomInputColorModel? userInputModel,
    bool? isLoginSuccess,
    bool? hasError,
    bool? isLoading,
  }) {
    return AuthScreenState(
      userInputModel: userInputModel ?? this.userInputModel,
      isLoginSuccess: isLoginSuccess ?? this.isLoginSuccess,
      hasError: hasError ?? this.hasError,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
