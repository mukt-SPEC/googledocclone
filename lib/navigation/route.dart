import 'package:flutter/material.dart';
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
