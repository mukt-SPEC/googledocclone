// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_quill/flutter_quill.dart';
import 'package:googledocclone/model/apperror.dart';

import 'package:googledocclone/state/controller_state.dart';

class DocumentState extends ControllerState {
  final String? id;
  final QuillController? quillController;
  final Document? quillDocument;

  const DocumentState({
    required this.id,
    this.quillController,
    this.quillDocument,
    super.error,
  });
  @override
  List<Object?> get props => [id, error];

  @override
  DocumentState copyWith({
    AppError? error,
    String? id,
    QuillController? quillController,
    Document? quillDocument,
  }) {
    return DocumentState(
      id: id ?? this.id,
      quillController: quillController ?? this.quillController,
      quillDocument: quillDocument ?? this.quillDocument,
      error: error ?? this.error,
    );
  }
}
