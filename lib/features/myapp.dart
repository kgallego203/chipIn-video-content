import 'package:chipin_video_content/features/authentication/views/auth_main_view.dart';
import 'package:chipin_video_content/themes/palette.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chipIn',
      theme: ThemeData(
        primaryColor: Palette.primary100,
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: Palette.primary200,
              background: Palette.primary300,
            ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Palette.primary300,
        ),
      ),
      home: const AuthMainView(), // This is the authentication main view
    );
  }
}
