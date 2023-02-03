import 'package:dartz/dartz.dart';
import 'package:tasks/core/errors/failures.dart';

abstract class Usecase<T> {
  Future<Either<Failure, T>> execute();
}
