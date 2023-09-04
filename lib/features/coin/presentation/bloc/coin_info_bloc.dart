import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_coin/features/coin/domain/entities/coin_info.dart';
import 'package:flutter_clean_architecture_coin/features/coin/domain/usecases/coin_info_use_case.dart';

part 'coin_info_event.dart';
part 'coin_info_state.dart';

class CoinInfoBloc extends Bloc<CoinInfoEvent, CoinInfoState> {
  final GetAllCoinInfo getAllCoinInfo;

  CoinInfoBloc({required this.getAllCoinInfo}) : super(CoinInfoState.initial()) {
    on<GetCoinInfo>((event, emit) async {
      await getCoinInfo(event, emit);
    });

    on<RefreshCoinInfo>((event, emit) async {
      await getCoinInfo(event, emit);
    });
  }

  Future<void> getCoinInfo(CoinInfoEvent event, Emitter<CoinInfoState> emit) async {
    emit(state.copyWith(status: CoinInfoStatus.loading));
    final coinListOrFailure = await getAllCoinInfo.call();

    if (event is GetCoinInfo) {
      print('get coin info eventi geldi');
      coinListOrFailure.match(
        (error) => emit(state.copyWith(status: CoinInfoStatus.error)),
        (coinList) => emit(state.copyWith(status: CoinInfoStatus.loaded, coinInfoList: coinList)),
      );
    }

    if (event is RefreshCoinInfo) {
      print('refresh coin info');
      print(coinListOrFailure);
      emit(state.copyWith(status: CoinInfoStatus.error, coinInfoList: []));
      // coinListOrFailure.match(
      //   (error) => emit(state.copyWith(status: CoinInfoStatus.error)),
      //   (coinList) => emit(state.copyWith(status: CoinInfoStatus.refresh, coinInfoList: List.from(coinList))),
      // );
    }
  }
}
