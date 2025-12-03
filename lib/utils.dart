import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledocclone/state/controller_state.dart';
import 'package:googledocclone/state/statebase.dart';
import 'package:logging/logging.dart';
import 'package:riverpod/misc.dart';

final Logger logger = Logger('AppLogger');

void setUpLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    String emoji = '';
    switch (record.level.name) {
      case 'SEVERE':
        emoji = '🔥';
        break;
      case 'WARNING':
        emoji = '⚠️';
        break;
      case 'INFO':
        emoji = 'ℹ️';
        break;
      case 'FINE':
        emoji = '🐛';
        break;
      default:
        emoji = '🔍';
    }

    debugPrint(
      '$emoji ${record.level.name}: ${record.time}: ${record.message}',
    );

    if (record.error != null) {
      debugPrint('Error: ${record.error}');
    }

    if (record.level == Level.SEVERE && record.stackTrace != null) {
      debugPrint('StackTrace: ${record.stackTrace}');
    }
  });
}

extension RefX on WidgetRef {
  void errorStateListener(
    BuildContext context,
    ProviderListenable<Statebase> provider,
  ) {
    listen<Statebase>(provider, (previous, next) {});
  }

  void errorControllerlistener(
    BuildContext context,
    ProviderListenable<ControllerState> provider,
  ) {
    listen<ControllerState>(provider, (previous, next) {
      final message = next.error?.message;
      if (next.error != previous!.error &&
          message != null &&
          message.isNotEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    });
  }
}
