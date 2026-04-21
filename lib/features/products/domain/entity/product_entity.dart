import 'package:equatable/equatable.dart';

import 'category_entity.dart';

class ProductEntity extends Equatable {
  const ProductEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
    this.creationAt,
    this.updatedAt,
  });

  final String id;
  final String title;
  final String slug;
  final int price;
  final String description;
  final CategoryEntity category;
  final List<String> images;
  final DateTime? creationAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [
    id,
    title,
    slug,
    price,
    description,
    category,
    images,
    creationAt,
    updatedAt,
  ];
}
