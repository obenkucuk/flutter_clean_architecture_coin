import 'package:flutter_clean_architecture_coin/features/coin/domain/entities/coin_info.dart';

class CoinInfoModel extends CoinInfo {
  const CoinInfoModel({
    super.id,
    super.rank,
    super.symbol,
    super.name,
    super.supply,
    super.maxSupply,
    super.marketCapUsd,
    super.volumeUsd24Hr,
    super.priceUsd,
    super.changePercent24Hr,
    super.vwap24Hr,
    super.explorer,
  });

  // fromJson
  factory CoinInfoModel.fromJson(Map<String, dynamic> data) {
    return CoinInfoModel(
      id: data['id'],
      rank: data['rank'],
      symbol: data['symbol'],
      name: data['name'],
      supply: data['supply'],
      maxSupply: data['maxSupply'],
      marketCapUsd: data['marketCapUsd'],
      volumeUsd24Hr: data['volumeUsd24Hr'],
      priceUsd: data['priceUsd'],
      changePercent24Hr: data['changePercent24Hr'],
      vwap24Hr: data['vwap24Hr'],
      explorer: data['explorer'],
    );
  }

  // toJson

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rank': rank,
      'symbol': symbol,
      'name': name,
      'supply': supply,
      'maxSupply': maxSupply,
      'marketCapUsd': marketCapUsd,
      'volumeUsd24Hr': volumeUsd24Hr,
      'priceUsd': priceUsd,
      'changePercent24Hr': changePercent24Hr,
      'vwap24Hr': vwap24Hr,
      'explorer': explorer,
    };
  }

  // copuWith
}
