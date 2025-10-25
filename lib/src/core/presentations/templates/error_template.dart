import 'package:coffee_venture_app/src/core/errors/failure.dart';
import 'package:coffee_venture_app/src/core/extensions/context_extension.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorTemplate extends StatelessWidget {
  const ErrorTemplate({Key? key, this.exception, this.onRetry}) : super(key: key);
  final BaseException? exception;
  final VoidCallback? onRetry;

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
          Text(context.intl.errorTitle, style: context.textStyles.titleMedium),
          if (exception != null)
            Text(
              'Error: ${kDebugMode ? exception!.message : context.intl.somethingWentWrong}',
              style: context.textStyles.bodyMedium,
            ),
          if (onRetry != null)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: CoffeeButton.icon(
                icon: const Icon(Icons.refresh, color: Colors.black),
                text: 'Try Again',
                onPressed: onRetry!,
                backgroundColor: context.colors.primary,
                textStyle: context.textStyles.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
        ],
      ),
    );
  }
}
