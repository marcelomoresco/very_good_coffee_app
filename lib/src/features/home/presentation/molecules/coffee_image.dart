import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CoffeeImage extends StatelessWidget {
  const CoffeeImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.showFavoriteIcon = false,
    this.borderRadius = 20,
  });

  final String imageUrl;
  final double? height;
  final double? width;
  final bool showFavoriteIcon;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 300),
              placeholder: (_, __) => Container(
                color: Colors.grey.shade900,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(strokeWidth: 2),
              ),
              errorWidget: (_, __, ___) => Container(
                color: Colors.grey.shade800,
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image_outlined, size: 48),
              ),
            ),
            if (showFavoriteIcon)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(8)),
                  child: Icon(Icons.favorite, color: context.colors.primary, size: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
