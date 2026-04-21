import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  const ImageEntity({
    required this.originalname,
    required this.filename,
    required this.location,
  });

  final String originalname;
  final String filename;
  final String location;

  @override
  List<Object?> get props => [originalname, filename, location];
}
