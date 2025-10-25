import 'package:coffee_venture_app/src/core/extensions/context_extension.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';

class EmptyTemplate extends StatelessWidget {
  const EmptyTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          Text(':(', style: context.textStyles.titleExtra),
          Text(context.intl.favoritesEmptyTitle, textAlign: TextAlign.center, style: context.textStyles.titleMedium),
          Text(context.intl.favoritesEmptyDescription, style: context.textStyles.bodyMedium),
        ],
      ),
    );
  }
}
