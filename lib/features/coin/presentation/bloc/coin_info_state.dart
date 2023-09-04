part of 'coin_info_bloc.dart';

abstract class CoinInfoState extends Equatable {
  const CoinInfoState();

  @override
  List<Object> get props => [];
}

class LoadingCoinInfo extends CoinInfoState {}

class LoadedCoinInfo extends CoinInfoState {
  final List<CoinInfo> coinInfoList;

  const LoadedCoinInfo({required this.coinInfoList});

  @override
  List<Object> get props => [
        coinInfoList,
      ];
}

class ErrorCoinInfo extends CoinInfoState {
  final String message;

  const ErrorCoinInfo({this.message = 'Something went wrong!'});

  @override
  List<Object> get props => [
        message,
      ];
}
