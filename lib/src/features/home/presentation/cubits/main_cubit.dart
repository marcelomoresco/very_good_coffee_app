import 'package:coffee_venture_app/src/core/helpers/very_good_venture_cubit.dart';

class MainCubit extends VeryGoodVentureCubit<int> {
  MainCubit() : super(0);

  void setIndex(int index) => emit(index);
}
