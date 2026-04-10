import 'package:clean_architecture_test/core/domain/entity/avaliability_filter_entity.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entity/app_image_entity.dart';

abstract class ProductsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductsFetched extends ProductsEvent {
  final String? categoryId;
  final String? search;
  final bool loadSilent;

  ProductsFetched({this.categoryId, this.search, this.loadSilent = true});

  @override
  List<Object?> get props => [categoryId, search, loadSilent];
}

class CategoriesFetched extends ProductsEvent {
  final bool loadSilent;

  CategoriesFetched({this.loadSilent = true});

  @override
  List<Object?> get props => [loadSilent];
}

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

class CreatedProductCategorySelected extends ProductsEvent {
  final String categoryId;

  CreatedProductCategorySelected({required this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}

class ProductCreated extends ProductsEvent {
  final String title;
  final String description;
  final int price;

  ProductCreated({
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  List<Object?> get props => [title, description, price];
}

class ProductDeleted extends ProductsEvent {
  final int id;

  ProductDeleted({required this.id});

  @override
  List<Object?> get props => [id];
}

class CategoryCreated extends ProductsEvent {
  final String name;

  CategoryCreated({required this.name});

  @override
  List<Object?> get props => [name];
}

class CategoryDeleted extends ProductsEvent {
  final int id;

  CategoryDeleted({required this.id});

  @override
  List<Object?> get props => [id];
}

class ImagePicked extends ProductsEvent {}

class ImageRemoved extends ProductsEvent {
  final AppImageEntity image;

  ImageRemoved({required this.image});

  @override
  List<Object?> get props => [image];
}

class ImageUploaded extends ProductsEvent {
  final AppImageEntity image;

  ImageUploaded({required this.image});

  @override
  List<Object?> get props => [image];
}

class DataRemoved extends ProductsEvent {}

class FilterAdded extends ProductsEvent {
  final AvailabilityFilterEntity filter;

  FilterAdded({required this.filter});

  @override
  List<Object?> get props => [filter];
}

class FilterRemoved extends ProductsEvent {
  final AvailabilityFilterEntity filter;

  FilterRemoved({required this.filter});

  @override
  List<Object?> get props => [filter];
}

class FiltersSaved extends ProductsEvent {
  final List<AvailabilityFilterEntity> filters;

  FiltersSaved({required this.filters});

  @override
  List<Object?> get props => [filters];
}
