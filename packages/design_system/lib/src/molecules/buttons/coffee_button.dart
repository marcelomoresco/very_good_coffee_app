import 'package:design_system/src/core/colors/app_colors.dart';
import 'package:design_system/src/core/extensions/context_theme_extension.dart';
import 'package:flutter/material.dart';

class CoffeeButton extends StatelessWidget {
  const CoffeeButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.isLoading = false,
    this.icon,
    this.textStyle,
  });

  factory CoffeeButton.icon({
    Key? key,
    required String text,
    required Widget icon,
    required VoidCallback onPressed,
    Color? backgroundColor,
    bool isLoading = false,
    TextStyle? textStyle,
  }) {
    return CoffeeButton(
      key: key,
      text: text,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      isLoading: isLoading,
      icon: icon,
      textStyle: textStyle,
    );
  }

  final String text;
  final TextStyle? textStyle;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final bool isLoading;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final Color bg = backgroundColor ?? colors.secondary ?? Colors.brown;
    final Color fg = colors.primary ?? Colors.white;

    final ButtonStyle style =
        ElevatedButton.styleFrom(
          backgroundColor: bg,
          splashFactory: InkRipple.splashFactory,
          foregroundColor: fg,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
            return null;
          }),
        );

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: style,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[icon!, const SizedBox(width: 8)],
                  Text(
                    text,
                    style: textStyle ?? TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: fg),
                  ),
                ],
              ),
      ),
    );
  }
}
