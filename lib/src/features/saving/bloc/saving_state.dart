part of 'saving_bloc.dart';

enum SavingStatus { initial, loading, success, failure }

enum UpdateStatus { initial, loading, success, failure }

class SavingState extends Equatable {
  final SavingStatus status;
  final UpdateStatus updateStatus;
  final List<SavingsResultResponseModel> savings;
  final SuccessResponseModel? result;
  final ErrorResponseModel? error;

  const SavingState({
    this.status = SavingStatus.initial,
    this.updateStatus = UpdateStatus.initial,
    this.savings = const <SavingsResultResponseModel>[],
    this.result,
    this.error,
  });

  SavingState copyWith({
    SavingStatus? status,
    UpdateStatus? updateStatus,
    List<SavingsResultResponseModel>? savings,
    SuccessResponseModel? result,
    ErrorResponseModel? error,
  }) {
    return SavingState(
      status: status ?? this.status,
      updateStatus: updateStatus ?? this.updateStatus,
      savings: savings ?? this.savings,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        updateStatus,
        savings,
        result,
        error,
      ];
}
