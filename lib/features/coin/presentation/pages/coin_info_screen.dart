import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_coin/features/coin/presentation/bloc/coin_info_bloc.dart';
import 'package:flutter_clean_architecture_coin/features/coin/presentation/widgets/refresh_widget.dart';
import 'package:flutter_clean_architecture_coin/injection.dart';
import 'package:intl/intl.dart';

class CoinInfoScreen extends StatelessWidget {
  const CoinInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<CoinInfoBloc>()..add(const GetCoinInfo()),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(pinned: true, title: Text('Coin Statistics')),
            SliverRefreshWidget(
                onRefresh: () {
                  return Future.delayed(const Duration(seconds: 3));
                },
                isRefreshing: true),
            BlocBuilder<CoinInfoBloc, CoinInfoState>(
              builder: (context, state) {
                if (state is LoadingCoinInfo) {
                  return const SliverFillRemaining(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state is LoadedCoinInfo) {
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    sliver: SliverList.builder(
                      itemBuilder: (context, index) {
                        final item = state.coinInfoList[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: const Color(0xfffafafa),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(width: 0.5, color: Colors.blue.shade100),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${item.name} / ${item.symbol}',
                                    ),
                                    Text(
                                      NumberFormat.compactSimpleCurrency(locale: 'en_US', decimalDigits: 2, name: '\$ ')
                                          .format(
                                        double.parse(item.volumeUsd24Hr ?? '0.0'),
                                      ),
                                      style: TextStyle(color: Colors.amber, fontSize: 24),
                                    ),
                                    Text(item.volumeUsd24Hr.convertedVolume),
                                  ],
                                ),
                                Text(
                                  NumberFormat.currency(
                                          locale: 'en_US',
                                          decimalDigits: double.parse(item.priceUsd ?? '0.0') > 0.01 ? 2 : 8,
                                          name: '\$ ')
                                      .format(
                                    double.parse(item.priceUsd ?? '0.0'),
                                  ),
                                  style: TextStyle(color: Colors.amber, fontSize: 24),
                                ),
                                const SizedBox(width: 30),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        );
                      },
                      // itemExtent: 150,
                      itemCount: state.coinInfoList.length,
                    ),
                  );
                } else if (state is ErrorCoinInfo) {
                  return SliverFillRemaining(child: Text(state.message));
                } else {
                  return const SliverFillRemaining(child: Text('Bilinmeyen bir hata oluştu!'));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

extension StringVolumeCast on String? {
  String get convertedVolume {
    if (this != null) {
      final stringList = this!.split('.');

      final String v;

      if (stringList.first.length == 13) {
        final value = stringList.first.substring(0, 6);
        v = '${value.substring(0, 4)},${value.substring(4, 6)}b';
      } else if (stringList.first.length == 12) {
        final value = stringList.first.substring(0, 5);
        v = '${value.substring(0, 3)},${value.substring(3, 5)}b';
      } else if (stringList.first.length == 11) {
        final value = stringList.first.substring(0, 4);
        v = '${value.substring(0, 2)},${value.substring(2, 4)}';
      } else if (stringList.first.length == 10) {
        final value = '${stringList.first.substring(0, 3)}b';
        v = '${value.substring(0, 1)},${value.substring(1, 3)}b';
      } else if (stringList.first.length == 9) {
        final value = stringList.first.substring(0, 5);
        v = '${value.substring(0, 3)},${value.substring(3, 5)}m';
      } else if (stringList.first.length == 8) {
        final value = stringList.first.substring(0, 4);
        v = '${value.substring(0, 2)},${value.substring(2, 4)}m';
      } else if (stringList.first.length == 7) {
        final value = stringList.first.substring(0, 3);
        v = '${value.substring(0, 1)},${value.substring(1, 3)}m';
      } else if (stringList.first.length == 6) {
        final value = stringList.first.substring(0, 5);
        v = '${value.substring(0, 3)},${value.substring(3, 5)}k';
      } else if (stringList.first.length == 5) {
        final value = stringList.first.substring(0, 4);
        v = '${value.substring(0, 2)},${value.substring(2, 4)}k';
      } else if (stringList.first.length == 4) {
        final value = stringList.first.substring(0, 3);
        v = '${value.substring(0, 1)},${value.substring(1, 3)}k';
      } else if (stringList.first.length == 3) {
        final value = stringList.first.substring(0, 3);
        v = value;
      } else if (stringList.first.length == 2) {
        final value = stringList.first.substring(0, 2);
        v = value;
      } else {
        final value = stringList.first.substring(0, 1);
        v = value;
      }

      return '\$$v';
    }

    return '0.0';
  }
}

extension StringPriceCast on String? {
  String get convertedPrice {
    if (this != null) {
      final stringList = this!.split('.');

      final String v;

      if (stringList.first.length == 6) {
        final value = stringList.first.substring(0, 5);
        v = '${value.substring(0, 3)},${value.substring(3, 5)}k';
      } else if (stringList.first.length == 5) {
        final value = stringList.first.substring(0, 4);
        v = '${value.substring(0, 2)},${value.substring(2, 4)}k';
      } else if (stringList.first.length == 4) {
        final value = stringList.first.substring(0, 3);
        v = '${value.substring(0, 1)},${value.substring(1, 3)}k';
      } else if (stringList.first.length == 3) {
        final value = stringList.first.substring(0, 3);
        v = value;
      } else if (stringList.first.length == 2) {
        final value = stringList.first.substring(0, 2);
        v = value;
      } else {
        final value = stringList.first.substring(0, 1);
        v = value;
      }

      return '\$$v';
    }

    return '0.0';
  }
}
