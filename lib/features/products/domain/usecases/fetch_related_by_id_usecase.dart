import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:clean_architecture_test/features/products/domain/entity/product_entity.dart';
import 'package:clean_architecture_test/features/products/domain/repository/products_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchRelatedByIdUseCase
    implements UseCase<List<ProductEntity>, FetchRelatedByIdParams> {
  FetchRelatedByIdUseCase(this.repository);

  final ProductsRepository repository;

  @override
  Future<Either<Failure, List<ProductEntity>>> call(
    FetchRelatedByIdParams params,
  ) async {
    return await repository.fetchRelatedById(id: params.id);
  }
}

class FetchRelatedByIdParams {
  FetchRelatedByIdParams({this.id});

  final String? id;
}
