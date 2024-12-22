part of 'saving_bloc.dart';

sealed class SavingEvent extends Equatable {
  const SavingEvent();

  @override
  List<Object> get props => [];
}

class SavingLoadByStatus extends SavingEvent {
  final String status;

  const SavingLoadByStatus({
    required this.status,
  });

  @override
  List<Object> get props => [
        status,
      ];
}

class SavingCreateData extends SavingEvent {
  final SavingRequestModel body;

  const SavingCreateData({
    required this.body,
  });

  @override
  List<Object> get props => [
        body,
      ];
}

class SavingUpdateAmount extends SavingEvent {
  final int id;
  final int amount;

  const SavingUpdateAmount({
    required this.id,
    required this.amount,
  });

  @override
  List<Object> get props => [
        id,
        amount,
      ];
}

class SavingWithdrawAmount extends SavingEvent {
  final int id;

  const SavingWithdrawAmount({
    required this.id,
  });

  @override
  List<Object> get props => [
        id,
      ];
}

class SavingSetInitialUpdate extends SavingEvent {}
