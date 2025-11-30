import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:googledocclone/utils.dart';

class Repoexception implements Exception {
  final String message;
  final Exception? exception;
  final StackTrace? stacktrace;
  const Repoexception({required this.message, this.exception, this.stacktrace});

  @override
  String toString() => "Repository Exception: $message";
}

mixin RepoexceptionMixin {
  Future<T> exceptionHandler<T>(
    FutureOr computation, {
    String unknownMessage = 'repository exception',
  }) async {
    try {
      return await computation;
    } on AppwriteException catch (e) {
      logger.warning(e.message, e);
      throw Repoexception(
        message: e.message ?? 'an unidentified error occured',
      );
    } on Exception catch (e, st) {
      logger.severe(unknownMessage, e, st);
      throw Repoexception(
        message: unknownMessage,
        exception: e,
        stacktrace: st,
      );
    }
  }
}
