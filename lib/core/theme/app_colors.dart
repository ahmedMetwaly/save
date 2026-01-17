import 'package:flutter/material.dart';

/// Modern color palette for the Save app
class AppColors {
  AppColors._();

  // Primary Gradient Colors
  static const Color primaryStart = Color(0xFF6366F1); // Indigo
  static const Color primaryEnd = Color(0xFF8B5CF6); // Purple

  // Secondary Colors
  static const Color secondary = Color(0xFF06B6D4); // Cyan
  static const Color accent = Color(0xFFF59E0B); // Amber

  // Background Colors - Light Mode
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);

  // Background Colors - Dark Mode
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color cardDark = Color(0xFF334155);

  // Text Colors - Light Mode
  static const Color textPrimaryLight = Color(0xFF1E293B);
  static const Color textSecondaryLight = Color(0xFF64748B);
  static const Color textHintLight = Color(0xFF94A3B8);

  // Text Colors - Dark Mode
  static const Color textPrimaryDark = Color(0xFFF1F5F9);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textHintDark = Color(0xFF64748B);

  // Semantic Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Border & Divider
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFF475569);

  // Shimmer Colors
  static const Color shimmerBaseLight = Color(0xFFE2E8F0);
  static const Color shimmerHighlightLight = Color(0xFFF1F5F9);
  static const Color shimmerBaseDark = Color(0xFF334155);
  static const Color shimmerHighlightDark = Color(0xFF475569);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryStart, primaryEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFFA855F7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Social Media Platform Colors
  static const Color facebook = Color(0xFF1877F2);
  static const Color instagram = Color(0xFFE4405F);
  static const Color twitter = Color(0xFF1DA1F2);
  static const Color youtube = Color(0xFFFF0000);
  static const Color linkedin = Color(0xFF0A66C2);
  static const Color tiktok = Color(0xFF000000);
  static const Color snapchat = Color.fromARGB(255, 231, 228, 27);
  static const Color chrome = Color(0xFF4285F4);
}
