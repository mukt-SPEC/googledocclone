import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledocclone/navigation/route.dart';
import 'package:googledocclone/provider/provider.dart';
import 'package:routemaster/routemaster.dart';

final _isaAuthenticatedProvider = Provider<bool>(
  (ref) => ref.watch(AppState.authState).isAuthenticated,
);
final _isaAuthLoaading = Provider<bool>(
  (ref) => ref.watch(AppState.authState).isLoading,
);

class GoogleDocsApp extends ConsumerStatefulWidget {
  const GoogleDocsApp({super.key});

  @override
  ConsumerState<GoogleDocsApp> createState() => _GoogleDocsAppState();
}

class _GoogleDocsAppState extends ConsumerState<GoogleDocsApp> {
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(_isaAuthLoaading);
    if (isLoading) {
      return Container(color: Colors.white);
    }

    return MaterialApp.router(
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) {
          final isAuthenticated = ref.watch(_isaAuthenticatedProvider);

          return isAuthenticated ? routeLoggedIn : routesLoggedout;
        },
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
