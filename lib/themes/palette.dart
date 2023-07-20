import 'package:flutter/material.dart';

class Palette {
  // Primary colors. These are generally used for main UI elements such as buttons, progress bars, etc.

  static const Color primary50 =
      Color.fromARGB(255, 252, 55, 121); // Lighter Pink
  static const Color primary100 = Color(0xFFf02e65); // Light Pink
  static const Color primary200 = Color(0xFFDA1A5B); // Medium Pink
  static const Color primary300 = Color(0xFFc00D53); // Dark Pink

  // Neutral colors. These are typically used for backgrounds, typography, borders, shadows, etc.
  static const Color neutral0 = Color(0xFFffffff); // White
  static const Color neutral5 = Color(0xFFFCFCFF); // Very Light Gray
  static const Color neutral10 = Color(0xFFf2f2f8); // Light Gray
  static const Color neutral30 = Color(0xFFE8E9F0); // Gray
  static const Color neutral50 = Color(0xFFC4C6D7); // Medium Gray
  static const Color neutral70 = Color(0xFF868EA3); // Dark Gray
  static const Color neutral100 = Color(0xFF616B7C); // Darker Gray
  static const Color neutral120 = Color(0xFF4F5769); // Even Darker Gray
  static const Color neutral150 = Color(0xFF373B4D); // More Darker Gray
  static const Color neutral200 =
      Color(0xFF282A3B); // More and More Darker Gray
  static const Color neutral300 = Color(0xFF1B1B28); // Even More Darker Gray
  static const Color neutral400 = Color(0xFF171723); // So Much Darker Gray
  static const Color neutral500 = Color(0xFF14141F); // The Darkest Gray

  // Information colors. These are typically used for informational messages or indicators.
  static const Color information10 = Color(0xFFF1FCFE); // Light Cyan
  static const Color information50 = Color(0xFFC8F2FC); // Cyan
  static const Color information100 = Color(0xFF00A7C3); // Dark Cyan
  static const Color information120 = Color(0xFF007187); // Darker Cyan
  static const Color information200 = Color(0xFF04333A); // The Darkest Cyan

  // Success colors. These are typically used for success messages or indicators.
  static const Color success10 = Color(0xFFEFFEF7); // Light Green
  static const Color success50 = Color(0xFFBFFCDD); // Green
  static const Color success100 = Color(0xFF00BC5D); // Dark Green
  static const Color success120 = Color(0xFF00754A); // Darker Green
  static const Color success200 = Color(0xFF06331C); // The Darkest Green

  // Warning colors. These are typically used for warning messages or indicators.
  static const Color warning10 = Color(0xFFFFF7EE); // Light Orange
  static const Color warning50 = Color(0xFFFFE1C0); // Orange
  static const Color warning100 = Color(0xFFF38500); // Dark Orange
  static const Color warning120 = Color(0xFFB34700); // Darker Orange
  static const Color warning200 = Color(0xFF462701); // The Darkest Orange
}
