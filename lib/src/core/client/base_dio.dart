import 'package:coffee_venture_app/src/core/constants/app_constants.dart';
import 'package:dio/io.dart';

class BaseDio extends DioForNative {
  BaseDio() {
    _configureDio();
  }

  void _configureDio() {
    // normally we use only 1 base url, so we can set it here
    options.baseUrl = AppConstants.baseUrl;
    options.connectTimeout = const Duration(seconds: 10);
    options.sendTimeout = const Duration(seconds: 10);
    options.receiveTimeout = const Duration(seconds: 10);
  }
}
