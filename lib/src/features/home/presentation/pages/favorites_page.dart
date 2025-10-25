import 'package:coffee_venture_app/src/core/helpers/status.dart';
import 'package:coffee_venture_app/src/core/helpers/very_good_venture_cubit_state.dart';
import 'package:coffee_venture_app/src/core/presentations/templates/empty_template.dart';
import 'package:coffee_venture_app/src/core/presentations/templates/error_template.dart';
import 'package:coffee_venture_app/src/core/presentations/templates/loading_template.dart';
import 'package:coffee_venture_app/src/features/home/presentation/cubits/coffee_cubit.dart';
import 'package:coffee_venture_app/src/features/home/presentation/cubits/coffee_state.dart';
import 'package:coffee_venture_app/src/features/home/presentation/cubits/favorites_cubit.dart';
import 'package:coffee_venture_app/src/features/home/presentation/cubits/favorites_state.dart';
import 'package:coffee_venture_app/src/features/home/presentation/templates/favorites_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends VeryGoodVentureCubitState<FavoritesPage, FavoritesCubit> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<CoffeeCubit, CoffeeState>(
        bloc: Modular.get<CoffeeCubit>(),
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.saveStatus == Status.success &&
            previous.coffee != current.coffee,
        listener: (context, state) {
          cubit.fetchAllFavoritesImages();
        },
        child: BlocBuilder<FavoritesCubit, FavoritesState>(
          bloc: cubit,
          builder: (context, state) {
            if (state.status.isLoading) return const LoadingTemplate();
            if (state.status.hasError) return ErrorTemplate(exception: state.exception);

            if (state.coffees.isEmpty) {
              return const EmptyTemplate();
            }

            return FavoritesTemplate(coffees: state.coffees);
          },
        ),
      ),
    );
  }
}
