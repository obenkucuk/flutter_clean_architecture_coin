import 'dart:convert';

import 'package:flutter_clean_architecture_coin/core/exceptions/exceptions.dart';
import 'package:flutter_clean_architecture_coin/features/coin/data/models/coin_info_model.dart';
import 'package:flutter_clean_architecture_coin/features/coin/domain/entities/coin_info.dart';

import 'package:http/http.dart' as http;

abstract class ICoinInfoRemoteDataSource {
  Future<List<CoinInfo>> getAllCoinInfos();
}

class CoinInfoRemoteDataSource implements ICoinInfoRemoteDataSource {
  final http.Client client;

  const CoinInfoRemoteDataSource({required this.client});

  @override
  Future<List<CoinInfo>> getAllCoinInfos() async {
    final response = await client.get(
      Uri.parse('https://api.coincap.io/v2/assets'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<CoinInfo> coinInfos;

      coinInfos = ((jsonDecode(response.body) as Map<String, dynamic>)['data'] as List<dynamic>)
          .map((coinInfo) => CoinInfoModel.fromJson(coinInfo))
          .toList();

      return coinInfos;
    }

    throw ServerException();
  }
}
