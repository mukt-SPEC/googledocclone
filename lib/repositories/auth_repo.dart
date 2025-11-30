import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledocclone/provider/provider.dart';
import 'package:googledocclone/repositories/repoexception.dart';

final _authRepositoryProvider = Provider<AuthRepository>((ref) {
  final account = ref.read(Dependency.account);
  return AuthRepository(account);
});

class AuthRepository with RepoexceptionMixin {
  final Account _account;

  AuthRepository(this._account);

  static Provider<AuthRepository> get provider => _authRepositoryProvider;

  Future<User> create({
    required String email,
    required String password,
    required String fullName,
  }) {
    return exceptionHandler(
      _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: fullName,
      ),
    );
  }

  Future<Session> createSession({
    required String email,
    required String password,
  }) {
    return exceptionHandler(
      _account.createEmailPasswordSession(email: email, password: password),
    );
  }

  Future<User> get() {
    return exceptionHandler(_account.get());
  }

  Future<void> deletesession({required String sessionId}) {
    return exceptionHandler(_account.deleteSession(sessionId: sessionId));
  }
}
