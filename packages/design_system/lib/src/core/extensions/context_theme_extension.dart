import 'package:design_system/src/core/colors/app_colors.dart';
import 'package:design_system/src/core/texts/app_text_styles.dart';
import 'package:flutter/material.dart';

extension ContextThemeExtension on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
  AppTextStyles get textStyles => Theme.of(this).extension<AppTextStyles>()!;
}
