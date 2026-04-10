import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:clean_architecture_test/features/products/domain/entity/app_image_entity.dart';
import 'package:clean_architecture_test/features/products/domain/entity/image_entity.dart';
import 'package:clean_architecture_test/features/products/domain/repository/products_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UploadImageUseCase implements UseCase<ImageEntity, UploadImageParams> {
  final ProductsRepository repository;

  UploadImageUseCase(this.repository);

  @override
  Future<Either<Failure, ImageEntity>> call(UploadImageParams params) async {
    return await repository.uploadImage(imageFile: params.image);
  }
}

class UploadImageParams {
  final AppImageEntity image;

  UploadImageParams({required this.image});
}
