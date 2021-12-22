import 'package:equatable/equatable.dart';

class DataState<T> extends Equatable {
  final bool isInProgress;
  final bool isFailure;
  final bool isSuccess;
  final bool isEmpty;
  final T? data;

  const DataState({
    this.isInProgress = false,
    this.isFailure = false,
    this.isSuccess = false,
    this.isEmpty = false,
    this.data,
  });

  factory DataState.initial() => const DataState();

  factory DataState.inProgress() => const DataState(isInProgress: true);

  factory DataState.failure() => const DataState(isFailure: true);

  factory DataState.empty() => const DataState(isEmpty: true);

  factory DataState.success(T data) => DataState(isSuccess: true, data: data);

  @override
  List<Object?> get props => [
        isInProgress,
        isFailure,
        isEmpty,
        isFailure,
        data,
      ];
}
