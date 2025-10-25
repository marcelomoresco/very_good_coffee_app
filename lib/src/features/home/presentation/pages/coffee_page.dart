import 'package:coffee_venture_app/src/core/extensions/context_extension.dart';
import 'package:coffee_venture_app/src/core/helpers/status.dart';
import 'package:coffee_venture_app/src/core/helpers/very_good_venture_cubit_state.dart';
import 'package:coffee_venture_app/src/core/presentations/templates/error_template.dart';
import 'package:coffee_venture_app/src/core/presentations/templates/loading_template.dart';
import 'package:coffee_venture_app/src/features/home/presentation/cubits/coffee_cubit.dart';
import 'package:coffee_venture_app/src/features/home/presentation/cubits/coffee_state.dart';
import 'package:coffee_venture_app/src/features/home/presentation/templates/coffee_template.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeePage extends StatefulWidget {
  const CoffeePage({super.key});
  @override
  State<CoffeePage> createState() => _CoffeePageState();
}

class _CoffeePageState extends VeryGoodVentureCubitState<CoffeePage, CoffeeCubit> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoffeeCubit, CoffeeState>(
      bloc: cubit,
      listener: (context, state) {
        if (state.saveStatus.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                context.intl.favoritesSaveError,
                style: context.textStyles.bodyMedium?.copyWith(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.status.isLoading) {
          return const LoadingTemplate();
        }
        if (state.status.isSuccess && state.coffee != null) {
          return CoffeeTemplate(
            coffee: state.coffee!,
            onFavorite: cubit.onFavoriteImage,
            onNext: cubit.onNext,
            isButtonLoading: state.isButtonLoading,
          );
        }
        if (state.status.hasError || state.exception != null) {
          return ErrorTemplate(exception: state.exception, onRetry: cubit.fetchRandomCoffeeImage);
        }
        return const Text('Something went wrong');
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (cubit.state.status.hasError) {
        cubit.fetchRandomCoffeeImage();
      }
    }
  }
}
