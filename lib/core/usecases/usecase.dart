import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Result, Params> {
  Future<Either<Failure, Result>> call(Params params);
}

class NoParams {}
