import 'package:coffee_venture_app/src/core/helpers/very_good_venture_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class VeryGoodVentureCubitState<TWidget extends StatefulWidget, TBind extends VeryGoodVentureCubit>
    extends State<TWidget> {
  final TBind _cubit = Modular.get<TBind>();
  TBind get cubit => _cubit;

  bool get shouldDisposeBind => true;

  @override
  void initState() {
    super.initState();
    cubit.onInitState();
  }

  T? _typedCubit<T>() => cubit as T;

  @override
  void dispose() {
    cubit.onDispose();
    if (shouldDisposeBind) {
      final isDisposed = Modular.dispose<TBind>();

      if (!isDisposed) {
        _typedCubit<Disposable>()?.dispose();
        _typedCubit<Sink>()?.close();
        _typedCubit<ChangeNotifier>()?.dispose();
      }
    }

    super.dispose();
  }
}
