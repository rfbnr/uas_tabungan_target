import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/datasources/auth_local_datasource.dart';
import '../../../data/datasources/auth_remote_datasource.dart';
import '../../../data/models/request/register_request_model.dart';
import '../../../data/models/response/error_response_model.dart';
import '../../../data/models/response/login_response_model.dart';
import '../../../data/models/response/register_response_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;

  AuthBloc({
    required this.authRemoteDatasource,
    required this.authLocalDatasource,
  }) : super(const AuthState()) {
    on<VisibilityPassword>(_onVisibilityPassword);
    on<VisibilityConfirmPassword>(_onVisibilityConfirmPassword);
    on<UserLogin>(_onUserLogin);
    on<UserRegister>(_onUserRegister);
    on<UserLogout>(_onUserLogout);
    on<GetUserLogin>(_onGetUserLogin);

    on<AuthSetInitial>(_onAuthSetInitial);
    on<LoginSetInitial>(_onLoginSetInitial);
    on<RegisterSetInitial>(_onRegisterSetInitial);
  }

  FutureOr<void> _onVisibilityPassword(
    VisibilityPassword event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(showPassword: !event.newValue),
    );
  }

  FutureOr<void> _onVisibilityConfirmPassword(
    VisibilityConfirmPassword event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(showConfirmPassword: !event.newValue),
    );
  }

  FutureOr<void> _onAuthSetInitial(
    AuthSetInitial event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        status: AuthStatus.initial,
        logoutStatus: LogoutStatus.initial,
        showPassword: true,
        showConfirmPassword: true,
      ),
    );
  }

  FutureOr<void> _onLoginSetInitial(
    LoginSetInitial event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        loginStatus: LoginStatus.initial,
        logoutStatus: LogoutStatus.initial,
        showPassword: true,
        showConfirmPassword: true,
      ),
    );
  }

  FutureOr<void> _onRegisterSetInitial(
    RegisterSetInitial event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        registerStatus: RegisterStatus.initial,
        logoutStatus: LogoutStatus.initial,
        showPassword: true,
        showConfirmPassword: true,
      ),
    );
  }

  Future<void> _onUserLogin(
    UserLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        loginStatus: LoginStatus.loading,
      ),
    );

    await Future.delayed(
        const Duration(
          seconds: 1,
        ), () async {
      try {
        final response = await authRemoteDatasource.login(
          email: event.email,
          password: event.password,
        );

        response.fold(
          (l) {
            emit(
              state.copyWith(
                loginStatus: LoginStatus.failure,
                error: l,
              ),
            );
            add(LoginSetInitial());
          },
          (r) {
            authLocalDatasource.saveAuthData(r);

            emit(
              state.copyWith(
                loginStatus: LoginStatus.success,
                dataLogin: r,
              ),
            );
            add(LoginSetInitial());
          },
        );
      } catch (e) {
        emit(
          state.copyWith(
            loginStatus: LoginStatus.failure,
            error: ErrorResponseModel(
              status: "error",
              message: e.toString(),
            ),
          ),
        );
        add(LoginSetInitial());
      }
    });
  }

  Future<void> _onUserRegister(
    UserRegister event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        registerStatus: RegisterStatus.loading,
      ),
    );

    await Future.delayed(
        const Duration(
          seconds: 1,
        ), () async {
      try {
        final response = await authRemoteDatasource.register(
          bodyRequestRegister: event.bodyRequestRegister,
        );

        response.fold(
          (l) {
            emit(
              state.copyWith(
                registerStatus: RegisterStatus.failure,
                error: l,
              ),
            );
            add(RegisterSetInitial());
          },
          (r) {
            emit(
              state.copyWith(
                registerStatus: RegisterStatus.success,
                dataRegister: r,
              ),
            );
            add(RegisterSetInitial());
          },
        );
      } catch (e) {
        emit(
          state.copyWith(
            registerStatus: RegisterStatus.failure,
            error: ErrorResponseModel(
              status: "error",
              message: e.toString(),
            ),
          ),
        );
        add(RegisterSetInitial());
      }
    });
  }

  Future<void> _onGetUserLogin(
    GetUserLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
      ),
    );

    try {
      final response = await authLocalDatasource.getAuthData();

      emit(
        state.copyWith(
          status: AuthStatus.success,
          dataLogin: response,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          error: ErrorResponseModel(
            status: "error",
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onUserLogout(
    UserLogout event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        logoutStatus: LogoutStatus.loading,
      ),
    );

    await Future.delayed(
        const Duration(
          seconds: 1,
        ), () async {
      try {
        final response = await authRemoteDatasource.logout();

        response.fold(
          (l) {
            emit(
              state.copyWith(
                logoutStatus: LogoutStatus.failure,
                messageLogout: l,
              ),
            );
          },
          (r) {
            emit(
              state.copyWith(
                logoutStatus: LogoutStatus.success,
                messageLogout: r,
              ),
            );

            authLocalDatasource.removeAuthData();

            add(AuthSetInitial());
          },
        );
      } catch (e) {
        emit(
          state.copyWith(
            logoutStatus: LogoutStatus.failure,
            error: ErrorResponseModel(
              status: "error",
              message: e.toString(),
            ),
          ),
        );
      }
    });
  }
}
