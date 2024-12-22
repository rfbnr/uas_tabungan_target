import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/datasources/saving_remote_datasource.dart';
import '../../../data/models/request/saving_request_model.dart';
import '../../../data/models/response/error_response_model.dart';
import '../../../data/models/response/savings_response_model.dart';
import '../../../data/models/response/success_response_model.dart';

part 'saving_event.dart';
part 'saving_state.dart';

class SavingBloc extends Bloc<SavingEvent, SavingState> {
  final SavingRemoteDatasource savingRemoteDatasource;

  SavingBloc({
    required this.savingRemoteDatasource,
  }) : super(const SavingState()) {
    on<SavingCreateData>(_onSavingCreateData);
    on<SavingLoadByStatus>(_onSavingLoadByStatus);
    on<SavingUpdateAmount>(_onSavingUpdateAmount);
    on<SavingWithdrawAmount>(_onSavingWithdrawAmount);

    on<SavingSetInitialUpdate>(_onSavingSetInitialUpdate);
  }

  Future<void> _onSavingSetInitialUpdate(
    SavingSetInitialUpdate event,
    Emitter<SavingState> emit,
  ) async {
    emit(
      state.copyWith(
        updateStatus: UpdateStatus.initial,
      ),
    );
  }

  Future<void> _onSavingCreateData(
    SavingCreateData event,
    Emitter<SavingState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SavingStatus.loading,
      ),
    );

    try {
      final response = await savingRemoteDatasource.addSaving(
        savingRequestModel: event.body,
      );

      response.fold(
        (l) {
          emit(
            state.copyWith(
              status: SavingStatus.failure,
              error: l,
            ),
          );
        },
        (r) {
          emit(
            state.copyWith(
              status: SavingStatus.success,
              result: SuccessResponseModel.fromJson(r.toJson()),
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SavingStatus.failure,
          error: ErrorResponseModel(
            status: "error",
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onSavingUpdateAmount(
    SavingUpdateAmount event,
    Emitter<SavingState> emit,
  ) async {
    emit(
      state.copyWith(
        updateStatus: UpdateStatus.loading,
      ),
    );

    try {
      final response = await savingRemoteDatasource.updateAmountSaving(
        amount: event.amount,
        id: event.id,
      );

      response.fold(
        (l) {
          emit(
            state.copyWith(
              updateStatus: UpdateStatus.failure,
              error: l,
            ),
          );
          add(SavingSetInitialUpdate());
        },
        (r) {
          emit(
            state.copyWith(
              updateStatus: UpdateStatus.success,
              result: SuccessResponseModel.fromJson(r.toJson()),
            ),
          );
          add(SavingSetInitialUpdate());
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          updateStatus: UpdateStatus.failure,
          error: ErrorResponseModel(
            status: "error",
            message: e.toString(),
          ),
        ),
      );
      add(SavingSetInitialUpdate());
    }
  }

  Future<void> _onSavingWithdrawAmount(
    SavingWithdrawAmount event,
    Emitter<SavingState> emit,
  ) async {
    emit(
      state.copyWith(
        updateStatus: UpdateStatus.loading,
      ),
    );

    try {
      final response = await savingRemoteDatasource.withdrawSaving(
        id: event.id,
      );

      response.fold(
        (l) {
          emit(
            state.copyWith(
              updateStatus: UpdateStatus.failure,
              error: l,
            ),
          );
          add(SavingSetInitialUpdate());
        },
        (r) {
          emit(
            state.copyWith(
              updateStatus: UpdateStatus.success,
              result: SuccessResponseModel.fromJson(r.toJson()),
            ),
          );
          add(SavingSetInitialUpdate());
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          updateStatus: UpdateStatus.failure,
          error: ErrorResponseModel(
            status: "error",
            message: e.toString(),
          ),
        ),
      );
      add(SavingSetInitialUpdate());
    }
  }

  Future<void> _onSavingLoadByStatus(
    SavingLoadByStatus event,
    Emitter<SavingState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SavingStatus.loading,
      ),
    );

    try {
      final response = await savingRemoteDatasource.getSavingByStatus(
        status: event.status,
      );

      response.fold(
        (l) {
          emit(
            state.copyWith(
              status: SavingStatus.failure,
              error: l,
            ),
          );
        },
        (r) {
          emit(
            state.copyWith(
              status: SavingStatus.success,
              savings: r.data,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SavingStatus.failure,
          error: ErrorResponseModel(
            status: "error",
            message: e.toString(),
          ),
        ),
      );
    }
  }
}
