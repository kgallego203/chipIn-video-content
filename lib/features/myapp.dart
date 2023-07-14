import 'package:chipin_video_content/features/authentication/views/auth_main_view.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chipIn',
      home: AuthMainView(), // This is the authentication main view
    );
  }
}
