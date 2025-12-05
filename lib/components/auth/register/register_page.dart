import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledocclone/components/auth/login/textfield.dart';
import 'package:googledocclone/components/auth/register/registercontroller.dart';
import 'package:googledocclone/navigation/route.dart';
import 'package:googledocclone/utils.dart';
import 'package:routemaster/routemaster.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _RegisterForm extends ConsumerStatefulWidget {
  const _RegisterForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __RegisterFormState();
}

class __RegisterFormState extends ConsumerState<_RegisterForm> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    if (_formkey.currentState!.validate()) {
      await ref
          .read(registerControllerNotifier.notifier)
          .createUser(
            email: _emailController.text,
            password: _passwordController.text,
            name: _nameController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.errorControllerlistener(context, registerControllerNotifier);
    return Padding(
      padding: EdgeInsetsGeometry.all(8.0),
      child: Center(
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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                EmailField(controller: _emailController),
                PasswordField(passwordController: _passwordController),
                NameField(controller: _nameController),

                ElevatedButton(onPressed: signIn, child: Text('Sign In')),
                Text.rich(
                  TextSpan(
                    text: 'Already have an account',
                    children: [
                      TextSpan(
                        text: 'Sign in',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () =>
                              Routemaster.of(context).push(RoutePath.login),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
