
import 'package:betalyze_mobile/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

typedef ResultFuture<T> = Future<Either<Failure,T>>;
typedef ResultVoid = Future<Either<Failure,void>>;
