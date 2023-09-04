import 'dart:convert';

import 'package:flutter_clean_architecture_coin/core/exceptions/exceptions.dart';
import 'package:flutter_clean_architecture_coin/features/coin/data/models/coin_info_model.dart';
import 'package:flutter_clean_architecture_coin/features/coin/domain/entities/coin_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const CACHED_COIN_INFOS = 'CACHED_COIN_INFOS';

abstract class ICoinInfoLocalDataSource {
  Future<List<CoinInfo>> getAllCoinInfos();
}

class CoinInfoLocalDataSource implements ICoinInfoLocalDataSource {
  final SharedPreferences sharedPreferences;
  const CoinInfoLocalDataSource({required this.sharedPreferences});

  @override
  Future<List<CoinInfo>> getAllCoinInfos() async {
    final jsonString = sharedPreferences.getString(CACHED_COIN_INFOS);

    if (jsonString != null) {
      final List<CoinInfo> coinInfos;
      coinInfos = (jsonDecode(jsonString) as List).map((coinInfo) => CoinInfoModel.fromJson(coinInfo)).toList();

      return Future.value(coinInfos);
    }

    throw CacheException();
  }
}
