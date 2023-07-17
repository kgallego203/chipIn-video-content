import 'package:appwrite/appwrite.dart';
import 'package:chipin_video_content/features/home_page.dart';
import 'package:flutter/material.dart';
import 'package:chipin_video_content/appwrite/appwrite_service.dart';

class OAuthService {
  static final Client client = AppwriteService.getClient();
  static final Account account = Account(client);

  // * Function for GitHub OAuth
  static Future<void> initiateGithubOAuth(context) async {
    try {
      await account.createOAuth2Session(
        provider: 'github',
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } on AppwriteException catch (e) {
      print('Appwrite Exception: ${e.message}');
    } catch (e) {
      print('Unknown Exception: $e');
    }
  }
}
