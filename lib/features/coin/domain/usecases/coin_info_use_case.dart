import 'package:flutter_clean_architecture_coin/core/errors/failures.dart';
import 'package:flutter_clean_architecture_coin/core/usecases/usecases.dart';
import 'package:flutter_clean_architecture_coin/features/coin/domain/entities/coin_info.dart';
import 'package:flutter_clean_architecture_coin/features/coin/domain/repositories/i_coin_info_repositories.dart';
import 'package:fpdart/fpdart.dart';

class GetAllCoinInfo implements CoinInfoUseCase<List<CoinInfo>> {
  final ICoinInfoRepository coinInfoRepository;
  GetAllCoinInfo({required this.coinInfoRepository});

  @override
  Future<Either<Failure, List<CoinInfo>>> call() {
    return coinInfoRepository.getAllCoinInfos();
  }
}
