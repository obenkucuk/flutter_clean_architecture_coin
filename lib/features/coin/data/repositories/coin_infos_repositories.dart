import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_clean_architecture_coin/core/errors/failures.dart';
import 'package:flutter_clean_architecture_coin/core/exceptions/exceptions.dart';
import 'package:flutter_clean_architecture_coin/features/coin/data/datasources/coin_info_local_data_source.dart';
import 'package:flutter_clean_architecture_coin/features/coin/data/datasources/coin_info_remote_data_source.dart';
import 'package:flutter_clean_architecture_coin/features/coin/domain/entities/coin_info.dart';
import 'package:flutter_clean_architecture_coin/features/coin/domain/repositories/i_coin_info_repositories.dart';
import 'package:fpdart/fpdart.dart';

class CoinInfoRepository implements ICoinInfoRepository {
  final ICoinInfoRemoteDataSource coinInfoRemoteDataSource;
  final ICoinInfoLocalDataSource coinInfoLocalDataSource;

  CoinInfoRepository({
    required this.coinInfoLocalDataSource,
    required this.coinInfoRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<CoinInfo>>> getAllCoinInfos() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      try {
        final coinInfoList = await coinInfoLocalDataSource.getAllCoinInfos();
        return Right(coinInfoList);
      } on CacheException {
        return Left(CacheFailure());
      }
    } else {
      try {
        final coinInfoList = await coinInfoRemoteDataSource.getAllCoinInfos();
        return Right(coinInfoList);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }
}
