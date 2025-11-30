import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final String message;
  late final int timeStamp;

  AppError({required this.message}) {
    timeStamp = DateTime.now().millisecondsSinceEpoch;
  }

  @override
  List<Object?> get props => [message, timeStamp];
}
