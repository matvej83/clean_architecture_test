import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductsFetched extends ProductsEvent {}

class ProductFetched extends ProductsEvent {
  final int id;

  ProductFetched(this.id);

  @override
  List<Object?> get props => [id];
}
