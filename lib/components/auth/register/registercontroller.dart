import 'package:googledocclone/model/apperror.dart';
import 'package:googledocclone/provider/provider.dart';
import 'package:googledocclone/repositories/auth_repo.dart';
import 'package:googledocclone/repositories/repoexception.dart';
import 'package:googledocclone/state/authstate.dart';
import 'package:googledocclone/state/controller_state.dart';
import 'package:riverpod/legacy.dart';

final registerControllerNotifier =
    StateNotifierProvider<Registercontroller, ControllerState>((ref) {
      final authRepository = ref.read(Repository.auth);
      final authstate = ref.read(AppState.authState.notifier);

      return Registercontroller(authstate, authRepository);
    });

class Registercontroller extends StateNotifier<ControllerState> {
  Registercontroller(this.authstate, this.authRepository)
    : super(ControllerState());

  final AuthService authstate;
  final AuthRepository authRepository;

  Future<void> createUser({required String name, email, password}) async {
    try {
      final user = await authRepository.create(
        email: email,
        password: password,
        fullName: name,
      );
      await authRepository.createSession(email: email, password: password);
      authstate.setUser(user);
    } on Repoexception catch (e) {
      state = state.copyWith(error: AppError(message: e.message));
    }
  }
}
