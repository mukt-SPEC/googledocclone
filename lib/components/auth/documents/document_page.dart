import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledocclone/app_color.dart';
import 'package:googledocclone/components/auth/documents/states/document_controller.dart';
import 'package:googledocclone/components/auth/documents/widget/menu_bar.dart';
import 'package:googledocclone/navigation/route.dart';
import 'package:googledocclone/provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tuple/tuple.dart';

class DocumentPage extends ConsumerStatefulWidget {
  final String? documentId;
  const DocumentPage({this.documentId, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumentPageState();
}

final _quillControllerProvider = Provider.family<QuillController?, String>((
  ref,
  id,
) {
  final test = ref.watch(documentProvider(id));
  return test.quillController;
});

class _DocumentPageState extends ConsumerState<DocumentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppMenuBar(
            leading: [],
            trailing: [],
            newDocumentPressed: () {
              Routemaster.of(context).push(RoutePath.newDocument);
            },
            signOutPressed: ref.read(AppState.authState.notifier).signOut,
            openDocumentsPressed: () {
              Future.delayed(const Duration(seconds: 0), () {});
            },
          ),
        ],
      ),
    );
  }
}

class _DocumentEditorWidget extends ConsumerStatefulWidget {
  const _DocumentEditorWidget({required this.documentId, super.key});

  final String documentId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __DocumentEditorWidgetState();
}

class __DocumentEditorWidgetState extends ConsumerState<_DocumentEditorWidget> {
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final quillController = ref.watch(
      _quillControllerProvider(widget.documentId),
    );
    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: KeyboardListener(
        focusNode: _focusNode,
        onKeyEvent: (event) {
          if (event.logicalKey == LogicalKeyboardKey.control &&
                  event.character == 'b' ||
              event.logicalKey == LogicalKeyboardKey.meta &&
                  event.character == 'b') {
            if (quillController.getSelectionStyle().attributes.keys.contains(
              'bold',
            )) {
              quillController.formatSelection(
                Attribute.clone(Attribute.bold, null),
              );
            } else {
              quillController.formatSelection(Attribute.bold);
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Card(
            elevation: 7,
            child: Padding(
              padding: const EdgeInsets.all(86.0),
              child: QuillEditor(
                focusNode: _focusNode,
                controller: quillController!,
                scrollController: _scrollController,
                config: QuillEditorConfig(
                  scrollable: true,

                  autoFocus: false,

                  expands: false,
                  padding: EdgeInsets.zero,
                  customStyles: DefaultStyles(
                    h1: DefaultTextBlockStyle(
                      const TextStyle(
                        fontSize: 36,
                        color: Colors.black,
                        height: 1.15,
                        fontWeight: FontWeight.w600,
                      ),
                      HorizontalSpacing(32, 24),
                      VerticalSpacing(0, 0),
                      VerticalSpacing(0, 0),
                      null,
                    ),
                    h2: DefaultTextBlockStyle(
                      const TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      HorizontalSpacing(28, 24),
                      VerticalSpacing(0, 0),
                      VerticalSpacing(0, 0),
                      null,
                    ),
                    h3: DefaultTextBlockStyle(
                      TextStyle(
                        fontSize: 24,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w600,
                      ),
                      HorizontalSpacing(18, 14),
                      VerticalSpacing(0, 0),
                      VerticalSpacing(0, 0),
                      null,
                    ),
                    paragraph: DefaultTextBlockStyle(
                      const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      HorizontalSpacing(2, 0),
                      VerticalSpacing(0, 0),
                      VerticalSpacing(0, 0),
                      null,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _defaultEmbedBuilderWeb(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
  ) {
    throw UnimplementedError(
      'Embeddable type "${node.value.type}" is not supported by default '
      'embed builder of QuillEditor. You must pass your own builder function '
      'to embedBuilder property of QuillEditor or QuillField widgets.',
    );
  }
}

class ToolBar extends ConsumerWidget {
  final String documentId;
  const ToolBar({required this.documentId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quillController = ref.watch(_quillControllerProvider(documentId));

    if (quillController == null) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    return QuillSimpleToolbar(
      controller: quillController,
      config: QuillSimpleToolbarConfig(
        iconTheme: const QuillIconTheme(
          iconButtonSelectedData: IconButtonData(color: AppColor.secondary),
        ),
        multiRowsDisplay: false,
        showAlignmentButtons: true,
      ),
    );
  }
}
