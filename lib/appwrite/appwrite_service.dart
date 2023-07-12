import 'package:appwrite/appwrite.dart';
import 'package:chipin_video_content/appwrite/appwrite_constants.dart';

class AppwriteService {
  static Client getClient() {
    final Client client = Client()
      ..setEndpoint(AppwriteConstants.apiEndpoint)
      ..setProject(AppwriteConstants.projectId);
    return client;
  }
}
