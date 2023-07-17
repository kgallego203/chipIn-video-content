import 'package:appwrite/appwrite.dart';
import 'package:chipin_video_content/appwrite/appwrite_service.dart';
import 'package:flutter/material.dart';

class AuthService {
  static final Client client = AppwriteService.getClient();
  static final Account account = Account(client);
  static final Databases databases = Databases(client);

  // * Signup method
  static Future<void> createUser(String firstname, String lastname,
      String username, String email, String password) async {
    try {
      await account.create(
        name: '$firstname $lastname',
        userId: username,
        email: email,
        password: password,
      );
      print('User created successfully');
    } catch (error) {
      print('Error creating user: $error');
      throw error;
    }
  }

  // * Login method
  static Future<void> createSession(
      BuildContext context, String email, String password) async {
    try {
      await account.createEmailSession(
        email: email,
        password: password,
      );
      print('Session created successfully');
    } catch (error) {
      print('Error creating session: $error');
      throw error;
    }
  }

  // * Logout method
  static Future<void> logout() async {
    try {
      await account.deleteSession(sessionId: 'current');
      print('Logged out successfully');
    } catch (e) {
      print('Failed to logout: $e');
      throw e;
    }
  }
}
