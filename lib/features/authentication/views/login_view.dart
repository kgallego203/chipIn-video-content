import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Add logic here
              },
              child: const Text('Login with GitHub'),
            ),
            const SizedBox(height: 16),
            const Divider(thickness: 1),
            const SizedBox(height: 16),
            TextFormField(
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
              onPressed: () async {},
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
