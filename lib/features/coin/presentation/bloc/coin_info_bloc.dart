import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_coin/features/coin/domain/entities/coin_info.dart';
import 'package:flutter_clean_architecture_coin/features/coin/domain/usecases/coin_info_use_case.dart';

part 'coin_info_event.dart';
part 'coin_info_state.dart';

class CoinInfoBloc extends Bloc<CoinInfoEvent, CoinInfoState> {
  final GetAllCoinInfo getAllCoinInfo;

  CoinInfoBloc({required this.getAllCoinInfo}) : super(LoadingCoinInfo()) {
    on<GetCoinInfo>((event, emit) async {
      await getCoinInfo(event, emit);
    });
  }

  Future<void> getCoinInfo(GetCoinInfo event, Emitter<CoinInfoState> emit) async {
    final coinListOrFailure = await getAllCoinInfo.call();

    coinListOrFailure.match(
      (error) => emit(const ErrorCoinInfo(message: 'Bir Hata Oldu!')),
      (coinList) => emit(LoadedCoinInfo(coinInfoList: coinList)),
    );
  }
}
