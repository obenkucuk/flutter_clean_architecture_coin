part of 'coin_info_bloc.dart';

abstract class CoinInfoEvent extends Equatable {
  const CoinInfoEvent();

  @override
  List<Object> get props => [];
}

class GetCoinInfo extends CoinInfoEvent {
  const GetCoinInfo();

  @override
  List<Object> get props => [];
}

class RefreshCoinInfo extends CoinInfoEvent {
  const RefreshCoinInfo();

  @override
  List<Object> get props => [];
}
