part of 'coin_info_bloc.dart';

enum CoinInfoStatus {
  initial,
  loading,
  loaded,
  error,
  refresh,
}

class CoinInfoState extends Equatable {
  final CoinInfoStatus status;
  final List<CoinInfo>? coinInfoList;
  final List<CoinInfo>? previousCoinInfoList;

  const CoinInfoState({required this.previousCoinInfoList, required this.status, required this.coinInfoList});

  static CoinInfoState initial() =>
      const CoinInfoState(status: CoinInfoStatus.loading, coinInfoList: null, previousCoinInfoList: null);

  CoinInfoState copyWith({
    CoinInfoStatus? status,
    List<CoinInfo>? coinInfoList,
    List<CoinInfo>? previousCoinInfoList,
  }) =>
      CoinInfoState(
        status: status ?? this.status,
        coinInfoList: coinInfoList ?? this.coinInfoList,
        previousCoinInfoList: previousCoinInfoList ?? this.previousCoinInfoList,
      );

  @override
  List<Object?> get props => [status, coinInfoList];
}
