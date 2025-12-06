import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledocclone/components/auth/documents/states/document_state.dart';
import 'package:riverpod/legacy.dart';

final documentProvider =
    StateNotifierProvider.family<DocumentController, DocumentState, String>(
      (ref, documentId) => DocumentController(documentId: documentId),
    );

class DocumentController extends StateNotifier<DocumentState> {
  DocumentController({this.read, required this.documentId})
    : super(DocumentState(id: documentId)) {
    _setUpDocument();
  }
  final Ref? read;
  final String documentId;

  Future<void> _setUpDocument() async {
    final quillDoc = Document()..insert(0, '');
    final controller = QuillController(
      document: quillDoc,
      selection: TextSelection.collapsed(offset: 0),
    );

    state = state.copyWith(
      quillController: controller,
      quillDocument: quillDoc,
    );
  }
}
