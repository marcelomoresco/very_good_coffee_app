import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({required this.primary, required this.background, required this.secondary});

  final Color? primary;
  final Color? background;
  final Color? secondary;

  @override
  AppColors copyWith({Color? primary, Color? background, Color? secondary}) {
    return AppColors(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      secondary: secondary ?? this.secondary,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t),
      background: Color.lerp(background, other.background, t),
      secondary: Color.lerp(secondary, other.secondary, t),
    );
  }
}
