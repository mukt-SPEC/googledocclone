import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

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
