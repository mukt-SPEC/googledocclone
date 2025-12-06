import 'package:flutter/material.dart';
import 'package:googledocclone/components/auth/documents/document_page.dart';
import 'package:googledocclone/components/auth/documents/new_document_page.dart';
import 'package:routemaster/routemaster.dart';

import '../components/auth/login/login_page.dart';
import '../components/auth/register/register_page.dart';

const _login = '/login';
const _register = '/register';
const _document = '/document';
const _newDocument = '/newDocument';

abstract class RoutePath {
  static String get login => _login;
  static String get register => _register;
  static String get document => _document;
  static String get newDocument => _newDocument;
}

final routesLoggedout = RouteMap(
  onUnknownRoute: (_) => const Redirect(_login),
  routes: {
    _login: (_) => const MaterialPage(child: LoginPage()),
    _register: (_) => const MaterialPage(child: RegisterPage()),
  },
);

final routeLoggedIn = RouteMap(
  onUnknownRoute: (_) => const Redirect(_newDocument),
  routes: {
    _newDocument: (_) => const MaterialPage(child: NewDocumentPage()),
    '$_document/:id': (info) {
      final docId = info.pathParameters['id'];
      if (docId == null) {
        return Redirect(_newDocument);
      }
      return MaterialPage(child: DocumentPage(documentId: docId));
    },
  },
);
