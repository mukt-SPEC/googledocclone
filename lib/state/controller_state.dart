import 'package:equatable/equatable.dart';
import 'package:googledocclone/model/apperror.dart';

class ControllerState extends Equatable {
  final AppError? error;

  const ControllerState({this.error});

  @override
  List<Object?> get props => [?error];

  ControllerState copyWith({AppError? error}) {
    return ControllerState(error: error ?? this.error);
  }
}
