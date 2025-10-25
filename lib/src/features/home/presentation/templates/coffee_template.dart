import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_venture_app/src/core/extensions/context_extension.dart';
import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:coffee_venture_app/src/features/home/presentation/molecules/coffee_image.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CoffeeTemplate extends StatefulWidget {
  const CoffeeTemplate({
    super.key,
    required this.coffee,
    required this.onFavorite,
    required this.onNext,
    this.isButtonLoading = false,
  });

  final Coffee coffee;
  final VoidCallback onFavorite;
  final VoidCallback onNext;
  final bool isButtonLoading;

  @override
  State<CoffeeTemplate> createState() => _CoffeeTemplateState();
}

class _CoffeeTemplateState extends State<CoffeeTemplate> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(CachedNetworkImageProvider(widget.coffee.imageUrl), context);
  }

  @override
  Widget build(BuildContext context) {
    const double imageSize = 350;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CoffeeImage(
            imageUrl: widget.coffee.imageUrl,
            height: imageSize,
            width: imageSize,
            borderRadius: 20,
            showFavoriteIcon: false,
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: CoffeeButton(
                  isLoading: widget.isButtonLoading,
                  onPressed: widget.onFavorite,
                  text: context.intl.coffeeSave,
                  backgroundColor: context.colors.primary,
                  textStyle: context.textStyles.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CoffeeButton.icon(
                  isLoading: widget.isButtonLoading,
                  icon: const Icon(Icons.next_plan_outlined, color: Colors.black, size: 24),
                  onPressed: widget.onNext,
                  text: context.intl.coffeeNext,
                  backgroundColor: context.colors.primary,
                  textStyle: context.textStyles.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
