import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_coin/features/coin/domain/entities/coin_info.dart';
import 'package:flutter_clean_architecture_coin/features/coin/domain/usecases/coin_info_use_case.dart';

part 'coin_info_state.dart';

class CoinInfoBloc extends Cubit<CoinInfoState> {
  final GetAllCoinInfo getAllCoinInfo;

  CoinInfoBloc({required this.getAllCoinInfo}) : super(CoinInfoState.initial()) {
    getCoinInfo(false);
  }

  Future<void> getCoinInfo(bool isRefresh) async {
    final coinListOrFailure = await getAllCoinInfo.call();

    coinListOrFailure.match(
      (error) => emit(state.copyWith(status: CoinInfoStatus.error)),
      (coinList) => emit(state.copyWith(
        status: isRefresh ? CoinInfoStatus.refresh : CoinInfoStatus.loaded,
        coinInfoList: List.of(coinList),
      )),
    );
  }
}
