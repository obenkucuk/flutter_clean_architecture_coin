import 'package:flutter_clean_architecture_coin/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class CoinInfoUseCase<ReturnType> {
  Future<Either<Failure, ReturnType>> call();
}
