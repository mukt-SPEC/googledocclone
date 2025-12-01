import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:googledocclone/model/apperror.dart';
import 'package:googledocclone/provider/provider.dart';
import 'package:googledocclone/repositories/auth_repo.dart';
import 'package:googledocclone/repositories/repoexception.dart';
import 'package:googledocclone/state/statebase.dart';
import 'package:googledocclone/utils.dart';

final _authServiceProvider = StateNotifierProvider<AuthService, Authstate>((
  ref,
) {
  final authrepo = ref.read(Repository.auth);
  return AuthService(authrepo);
});

class AuthService extends StateNotifier<Authstate> {
  AuthService(this.authRepository)
    : super(const Authstate.unauthenticated(isLoading: true)) {
    refresh();
  }

  static StateNotifierProvider<AuthService, Authstate> get provider =>
      _authServiceProvider;

  AuthRepository authRepository;

  Future<void> refresh() async {
    try {
      final user = await authRepository.get();
      setUser(user);
    } on Repoexception catch (_) {
      logger.info("Not authenticated");
      state = const Authstate.unauthenticated();
    }
  }

  void setUser(User user) {
    logger.info('Authentication successful, setting $user');
    state = state.copyWith(user: user, isLoading: false);
  }

  Future<void> signOut() async {
    try {
      await authRepository.deletesession(sessionId: 'current');
      logger.info('Sign out succesfully');
      state = const Authstate.unauthenticated();
    } on Repoexception catch (e) {
      state = state.copyWith(error: AppError(message: e.message));
    }
  }
}

class Authstate extends Statebase {
  final User? user;
  final bool isLoading;

  const Authstate({this.user, this.isLoading = false, super.error});

  const Authstate.unauthenticated({this.isLoading = false})
    : user = null,
      super(error: null);

  @override
  List<Object?> get props => [user, isLoading, error];

  bool get isAuthenticated => user != null;

  Authstate copyWith({User? user, bool? isLoading, AppError? error}) {
    return Authstate(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
