import 'package:equatable/equatable.dart';

const noParams = NoParams();

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
