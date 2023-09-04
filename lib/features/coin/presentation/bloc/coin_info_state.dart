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

  const CoinInfoState({required this.status, required this.coinInfoList});

  static CoinInfoState initial() => const CoinInfoState(
        status: CoinInfoStatus.initial,
        coinInfoList: null,
      );

  CoinInfoState copyWith({CoinInfoStatus? status, List<CoinInfo>? coinInfoList}) => CoinInfoState(
        status: status ?? this.status,
        coinInfoList: coinInfoList ?? this.coinInfoList,
      );

  @override
  List<Object?> get props => [status, coinInfoList];
}
