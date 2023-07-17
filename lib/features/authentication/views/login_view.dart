import 'package:chipin_video_content/features/authentication/controller/auth_controller.dart';
import 'package:chipin_video_content/features/authentication/services/oauth_service.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: loginController.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await OAuthService.initiateGithubOAuth(context);
              },
              child: const Text('Login with GitHub'),
            ),
            const SizedBox(height: 16),
            const Text('Or'),
            const SizedBox(height: 16),
            TextFormField(
              controller: loginController.emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: loginController.passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (loginController.formKey.currentState != null &&
                    loginController.formKey.currentState!.validate()) {
                  await loginController.login(context);
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
