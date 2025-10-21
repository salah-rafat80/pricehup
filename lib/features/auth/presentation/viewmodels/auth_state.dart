/// State for authentication feature
class AuthState {
  final String mobileNumber;
  final bool isLoading;
  final String? error;
  final bool isOtpSent;

  const AuthState({
    this.mobileNumber = '',
    this.isLoading = false,
    this.error,
    this.isOtpSent = false,
  });

  AuthState copyWith({
    String? mobileNumber,
    bool? isLoading,
    String? error,
    bool? isOtpSent,
  }) {
    return AuthState(
      mobileNumber: mobileNumber ?? this.mobileNumber,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isOtpSent: isOtpSent ?? this.isOtpSent,
    );
  }
}

