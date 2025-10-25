import 'package:coffee_venture_app/src/core/errors/failure.dart';
import 'package:coffee_venture_app/src/core/helpers/status.dart';
import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';

class CoffeeState {
  const CoffeeState({
    this.status = Status.initial,
    this.saveStatus = Status.initial,
    this.coffee,
    this.exception,
    this.isButtonLoading = false,
  });
  final Status status;
  final Status saveStatus;
  final Coffee? coffee;
  final BaseException? exception;
  final bool isButtonLoading;

  CoffeeState copyWith({
    Status? status,
    Status? saveStatus,
    Coffee? coffee,
    BaseException? exception,
    bool? isButtonLoading,
  }) {
    return CoffeeState(
      status: status ?? this.status,
      saveStatus: saveStatus ?? this.saveStatus,
      coffee: coffee ?? this.coffee,
      exception: exception ?? this.exception,
      isButtonLoading: isButtonLoading ?? this.isButtonLoading,
    );
  }

  @override
  bool operator ==(covariant CoffeeState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.saveStatus == saveStatus &&
        other.coffee == coffee &&
        other.exception == exception &&
        other.isButtonLoading == isButtonLoading;
  }

  @override
  int get hashCode {
    return status.hashCode ^ saveStatus.hashCode ^ coffee.hashCode ^ exception.hashCode ^ isButtonLoading.hashCode;
  }
}
