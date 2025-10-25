import 'package:coffee_venture_app/src/core/errors/failure.dart';
import 'package:coffee_venture_app/src/core/helpers/status.dart';
import 'package:coffee_venture_app/src/features/home/domain/entities/coffee.dart';
import 'package:flutter/foundation.dart';

class FavoritesState {
  const FavoritesState({this.status = Status.initial, this.coffees = const [], this.exception});
  final Status status;
  final List<Coffee> coffees;
  final BaseException? exception;

  @override
  bool operator ==(covariant FavoritesState other) {
    if (identical(this, other)) return true;

    return other.status == status && listEquals(other.coffees, coffees) && other.exception == exception;
  }

  @override
  int get hashCode => status.hashCode ^ coffees.hashCode ^ exception.hashCode;

  FavoritesState copyWith({Status? status, List<Coffee>? coffees, BaseException? exception}) {
    return FavoritesState(
      status: status ?? this.status,
      coffees: coffees ?? this.coffees,
      exception: exception ?? this.exception,
    );
  }
}
