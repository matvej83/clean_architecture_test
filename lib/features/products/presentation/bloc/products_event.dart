import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductsFetched extends ProductsEvent {
  final String? categoryId;
  final bool loadSilent;

  ProductsFetched({this.categoryId, this.loadSilent = true});

  @override
  List<Object?> get props => [categoryId, loadSilent];
}

class CategoriesFetched extends ProductsEvent {}

class ProductFetched extends ProductsEvent {
  final String id;

  ProductFetched(this.id);

  @override
  List<Object?> get props => [id];
}

class RelatedByIdFetched extends ProductsEvent {
  final String id;

  RelatedByIdFetched(this.id);

  @override
  List<Object?> get props => [id];
}
