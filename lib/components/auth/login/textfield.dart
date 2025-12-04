import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController? controller;
  const EmailField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: 'Enter Email'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Cannot be empty';
        } else if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        ).hasMatch(value)) {
          return 'Not a valid email address';
        }
        return null;
      },
    );
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController passwordController;
  const PasswordField({required this.passwordController, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      decoration: const InputDecoration(hintText: 'Password'),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Cannot be empty';
        }
        return null;
      },
    );
  }
}

class NameField extends StatelessWidget {
  final TextEditingController controller;
  const NameField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(hintText: 'Name'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Cannot be empty';
        }
        return null;
      },
    );
  }
}
