import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
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

  // * Method to get the name of the currently logged in user
  static Future<String> getUserName() async {
    try {
      User response = await account.get();
      return response.name;
    } catch (e) {
      print('Failed to get user name: $e');
      throw e;
    }
  }

  // * Method to get the currently logged in user's ID
  static Future<String> getCreatorId() async {
    try {
      User response = await account.get();
      return response.$id;
    } catch (e) {
      print('Failed to get user ID: $e');
      throw e;
    }
  }
}
