import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledocclone/components/auth/login/login_controller.dart';
import 'package:googledocclone/utils.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _LoginForm extends ConsumerStatefulWidget {
  const _LoginForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __LoginFormState();
}

class __LoginFormState extends ConsumerState<_LoginForm> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signOut() async {
    if (_formkey.currentState!.validate()) {
      await ref
          .read(loginControllerProvider.notifier)
          .createSession(
            email: _emailController.text,
            password: _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.errorControllerlistener(context, loginControllerProvider);
    return Padding(
      padding: EdgeInsetsGeometry.all(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints.loose(const Size.fromWidth(320)),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 8),
                  child: Text(
                    'Google Doc clone from tutorial with appwrite as backend and riverpod',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
