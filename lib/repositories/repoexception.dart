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
    } catch (e, st) {
      // Catch any non-`Exception` throw (for example JS rejecting a Promise
      // with `null` or a non-Error). Those may not include a stack trace
      // coming from JS; ensure we wrap them in a Repoexception and provide
      // a Dart-side stack trace so callers can debug.
      logger.severe('Non-Exception thrown', e, st);
      final Exception normalized = (e is Exception)
          ? e 
          : Exception('Non-exception thrown from platform: $e');
      throw Repoexception(
        message: unknownMessage,
        exception: normalized,
        stacktrace: st ,
      );
    }
  }
}
