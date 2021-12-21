import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_state.freezed.dart';

@freezed
class DataState<T> with _$DataState {
  const factory DataState.initial() = Initial;
  const factory DataState.inProgress() = InProgress;
  const factory DataState.failure([int? statusCode]) = Failure;
  const factory DataState.success(T data) = Success;
}
