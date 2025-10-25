import 'package:coffee_venture_app/src/core/helpers/status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StatusExtension', () {
    test('isLoading is true only for loading', () {
      expect(Status.initial.isLoading, isFalse);
      expect(Status.loading.isLoading, isTrue);
      expect(Status.success.isLoading, isFalse);
      expect(Status.error.isLoading, isFalse);
    });

    test('isSuccess is true only for success', () {
      expect(Status.initial.isSuccess, isFalse);
      expect(Status.loading.isSuccess, isFalse);
      expect(Status.success.isSuccess, isTrue);
      expect(Status.error.isSuccess, isFalse);
    });

    test('hasError is true only for error', () {
      expect(Status.initial.hasError, isFalse);
      expect(Status.loading.hasError, isFalse);
      expect(Status.success.hasError, isFalse);
      expect(Status.error.hasError, isTrue);
    });

    test('mutual exclusivity sanity check', () {
      for (final s in Status.values) {
        final flags = [s.isLoading, s.isSuccess, s.hasError];

        expect(flags.where((v) => v).length <= 1, isTrue, reason: 'Only one flag should be true for $s');
      }
    });
  });
}
