import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final String originalname;
  final String filename;
  final String location;

  const ImageEntity({
    required this.originalname,
    required this.filename,
    required this.location,
  });

  @override
  List<Object?> get props => [originalname, filename, location];
}
