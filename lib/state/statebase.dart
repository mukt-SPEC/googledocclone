import 'package:equatable/equatable.dart';
import 'package:googledocclone/model/apperror.dart';

class Statebase extends Equatable {
  final AppError? error;

  const Statebase({this.error});

  @override
  List<Object?> get props => [error];
}
