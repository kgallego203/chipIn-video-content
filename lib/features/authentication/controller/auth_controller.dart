import 'package:chipin_video_content/features/authentication/services/auth_service.dart';
import 'package:chipin_video_content/features/home_page.dart';
import 'package:flutter/material.dart';

class LoginController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      await AuthService.createSession(context, email, password);

      emailController.text = '';
      passwordController.text = '';

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logged in successfully'),
        ),
      );
    }
  }
}

class SignUpController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> signUp(BuildContext context) async {
    final firstname = firstNameController.text;
    final lastname = lastNameController.text;
    final email = emailController.text;
    final username = usernameController.text;
    final password = passwordController.text;

    try {
      await AuthService.createUser(
        firstname,
        lastname,
        username,
        email,
        password,
      );

      firstNameController.text = '';
      lastNameController.text = '';
      emailController.text = '';
      usernameController.text = '';
      passwordController.text = '';
      confirmPasswordController.text = '';

      const snackBar = SnackBar(
        content: Text('Account Created!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      await AuthService.createSession(context, email, password);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } catch (error) {
      final snackbar = SnackBar(
        content: Text('Error creating account: $error'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
