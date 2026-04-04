import 'dart:io';

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

class CategorySelected extends ProductsEvent {
  final String? categoryId;

  CategorySelected({this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}

class CreatedProductCategorySelected extends ProductsEvent {
  final String? categoryId;

  CreatedProductCategorySelected({this.categoryId});

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

class ImagePicked extends ProductsEvent {}

class ImageRemoved extends ProductsEvent {
  final File file;

  ImageRemoved({required this.file});

  @override
  List<Object?> get props => [file];
}

class ImageUploaded extends ProductsEvent {
  final File image;

  ImageUploaded({required this.image});

  @override
  List<Object?> get props => [image];
}

class DataRemoved extends ProductsEvent {}
