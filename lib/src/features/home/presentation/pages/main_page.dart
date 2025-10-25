import 'package:coffee_venture_app/src/core/extensions/context_extension.dart';
import 'package:coffee_venture_app/src/core/helpers/very_good_venture_cubit_state.dart';
import 'package:coffee_venture_app/src/features/home/presentation/cubits/main_cubit.dart';
import 'package:coffee_venture_app/src/features/home/presentation/pages/coffee_page.dart';
import 'package:coffee_venture_app/src/features/home/presentation/pages/favorites_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  static const routeName = '/main';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends VeryGoodVentureCubitState<MainPage, MainCubit> {
  static const _pages = [CoffeePage(), FavoritesPage()];

  @override
  Widget build(BuildContext context) {
    final navColor = Theme.of(context).colorScheme.surface;

    return BlocBuilder<MainCubit, int>(
      bloc: cubit,
      builder: (context, index) {
        return Scaffold(
          backgroundColor: navColor,
          body: IndexedStack(index: index, children: _pages),
          bottomNavigationBar: NavigationBar(
            selectedIndex: index,
            onDestinationSelected: cubit.setIndex,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: [
              NavigationDestination(icon: const Icon(Icons.coffee_rounded), label: context.intl.coffee),
              NavigationDestination(icon: const Icon(Icons.favorite_rounded), label: context.intl.favorites),
            ],
          ),
        );
      },
    );
  }
}
