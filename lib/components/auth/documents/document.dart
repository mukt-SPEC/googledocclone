import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentPage extends ConsumerStatefulWidget {
  final String? documentId;
  const DocumentPage({this.documentId, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumentPageState();
}

class _DocumentPageState extends ConsumerState<DocumentPage> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}