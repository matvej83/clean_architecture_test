import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  const CategoryEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.slug,
  });

  final String id;
  final String name;
  final String image;
  final String slug;

  @override
  List<Object?> get props => [id, name, image, slug];
}
