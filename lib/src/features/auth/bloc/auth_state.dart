part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, failure }

enum LoginStatus { initial, loading, success, failure }

enum RegisterStatus { initial, loading, success, failure }

enum LogoutStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  final AuthStatus? status;
  final LoginStatus? loginStatus;
  final RegisterStatus? registerStatus;
  final LogoutStatus? logoutStatus;
  final LoginResponseModel? dataLogin;
  final RegisterResponseModel? dataRegister;
  final bool? showPassword;
  final bool? showConfirmPassword;
  final String? messageLogout;
  final ErrorResponseModel? error;

  const AuthState({
    this.status = AuthStatus.initial,
    this.loginStatus = LoginStatus.initial,
    this.registerStatus = RegisterStatus.initial,
    this.logoutStatus = LogoutStatus.initial,
    this.dataLogin,
    this.dataRegister,
    this.showPassword = true,
    this.showConfirmPassword = true,
    this.messageLogout,
    this.error,
  });

  AuthState copyWith({
    AuthStatus? status,
    LoginStatus? loginStatus,
    RegisterStatus? registerStatus,
    LogoutStatus? logoutStatus,
    LoginResponseModel? dataLogin,
    RegisterResponseModel? dataRegister,
    bool? showPassword,
    bool? showConfirmPassword,
    String? messageLogout,
    ErrorResponseModel? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      loginStatus: loginStatus ?? this.loginStatus,
      registerStatus: registerStatus ?? this.registerStatus,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      dataLogin: dataLogin ?? this.dataLogin,
      dataRegister: dataRegister ?? this.dataRegister,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      messageLogout: messageLogout ?? this.messageLogout,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        loginStatus,
        registerStatus,
        logoutStatus,
        dataLogin,
        dataRegister,
        showPassword,
        showConfirmPassword,
        messageLogout,
        error,
      ];
}
