import 'package:flutter/material.dart';

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  const AppTextStyles({required this.titleExtra, required this.titleMedium, required this.bodyMedium});

  final TextStyle? titleExtra;
  final TextStyle? titleMedium;
  final TextStyle? bodyMedium;

  @override
  AppTextStyles copyWith({TextStyle? titleExtra, TextStyle? titleMedium, TextStyle? bodyMedium}) {
    return AppTextStyles(
      titleExtra: titleExtra ?? this.titleExtra,
      titleMedium: titleMedium ?? this.titleMedium,
      bodyMedium: bodyMedium ?? this.bodyMedium,
    );
  }

  @override
  AppTextStyles lerp(ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) return this;
    return AppTextStyles(
      titleExtra: TextStyle.lerp(titleExtra, other.titleExtra, t),
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t),
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t),
    );
  }
}
