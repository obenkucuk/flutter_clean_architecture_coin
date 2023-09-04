import 'package:flutter_clean_architecture_coin/core/errors/failures.dart';
import 'package:flutter_clean_architecture_coin/features/coin/domain/entities/coin_info.dart';
import 'package:fpdart/fpdart.dart';

abstract class ICoinInfoRepository {
  Future<Either<Failure, List<CoinInfo>>> getAllCoinInfos();
}
