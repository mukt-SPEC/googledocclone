import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledocclone/app.dart';
import 'package:googledocclone/utils.dart';

void main() {
  setUpLogger();

  runApp(const ProviderScope(child: GoogleDocsApp()));
}
 