import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledocclone/components/auth/documents/widget/menu_bar.dart';
import 'package:googledocclone/navigation/route.dart';
import 'package:googledocclone/provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class DocumentPage extends ConsumerStatefulWidget {
  final String? documentId;
  const DocumentPage({this.documentId, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumentPageState();
}

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
