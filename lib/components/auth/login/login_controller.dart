import 'package:appwrite/appwrite.dart';
import 'package:googledocclone/model/apperror.dart';
import 'package:googledocclone/provider/provider.dart';
import 'package:googledocclone/repositories/auth_repo.dart';
import 'package:googledocclone/repositories/repoexception.dart';
import 'package:googledocclone/state/authstate.dart';
import 'package:googledocclone/state/controller_state.dart';
import 'package:riverpod/legacy.dart';

final loginControllerProvider =
    StateNotifierProvider<LoginController, ControllerState>((ref) {
      final appState = ref.read(AppState.authState.notifier);
      final authrepo = ref.read(Repository.auth);
      return LoginController(authrepo, appState);
    });

class LoginController extends StateNotifier<ControllerState> {
  LoginController(this.authRepository, this.authState) : super(ControllerState());

  AuthRepository authRepository;
  AuthService authState;

  Future<void> createSession({
    required String email,
    required String password,
  }) async {
    try {
      await authRepository.createSession(email: email, password: password);
      final user = await authRepository.get();
      authState.setUser(user);
    } on Repoexception catch (e) {
      state = state.copyWith(error: AppError(message: e.message));
    }
  }
}
