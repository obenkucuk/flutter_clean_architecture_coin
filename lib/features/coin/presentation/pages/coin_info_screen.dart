import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_coin/features/coin/presentation/bloc/coin_info_bloc.dart';
import 'package:flutter_clean_architecture_coin/features/coin/presentation/widgets/list_titles.dart';
import 'package:flutter_clean_architecture_coin/features/coin/presentation/widgets/refresh_widget.dart';
import 'package:flutter_clean_architecture_coin/features/coin/presentation/widgets/single_list_item.dart';
import 'package:flutter_clean_architecture_coin/injection.dart';

class CoinInfoScreen extends StatelessWidget {
  const CoinInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: const Text('Coin Statistics'),
            bottom: PreferredSize(
              preferredSize: Size.fromRadius(MediaQuery.sizeOf(context).height * 0.01),
              child: const ListTitles(),
            ),
          ),
          SliverRefreshWidget(
            onRefresh: () {
              sl.get<CoinInfoBloc>().add(const RefreshCoinInfo());
              return Future.delayed(const Duration(seconds: 3));
            },
            isRefreshing: true,
          ),
          BlocBuilder<CoinInfoBloc, CoinInfoState>(
            bloc: context.read<CoinInfoBloc>(),
            builder: (context, state) {
              if (state.status == CoinInfoStatus.loading) {
                return const SliverFillRemaining(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state.status == CoinInfoStatus.loaded) {
                print('Widget loaded yeri');

                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  sliver: SliverList.builder(
                    itemBuilder: (context, index) {
                      final item = state.coinInfoList![index];
                      final changePercent24Hr = double.parse(item.changePercent24Hr ?? '0.0');
                      final color = changePercent24Hr > 0
                          ? Colors.green
                          : changePercent24Hr == 0
                              ? Colors.grey
                              : Colors.red;

                      return SingleListItem(
                        color: color,
                        changePercent24Hr: changePercent24Hr,
                        priceUsd: item.priceUsd,
                        name: item.name,
                        symbol: item.symbol,
                        volumeUsd24Hr: item.volumeUsd24Hr,
                      );
                    },
                    // itemExtent: 150,
                    itemCount: state.coinInfoList!.length,
                  ),
                );
              } else if (state.status == CoinInfoStatus.refresh) {
                print('Widget refresh yeri');

                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  sliver: SliverList.builder(
                    itemBuilder: (context, index) {
                      final item = state.coinInfoList![index];
                      final changePercent24Hr = double.parse(item.changePercent24Hr ?? '0.0');
                      final color = changePercent24Hr > 0
                          ? Colors.green
                          : changePercent24Hr == 0
                              ? Colors.grey
                              : Colors.red;

                      return SingleListItem(
                        color: color,
                        changePercent24Hr: changePercent24Hr,
                        priceUsd: item.priceUsd,
                        name: item.name,
                        symbol: item.symbol,
                        volumeUsd24Hr: item.volumeUsd24Hr,
                      );
                    },
                    // itemExtent: 150,
                    itemCount: state.coinInfoList!.length,
                  ),
                );
              } else if (state.status == CoinInfoStatus.error) {
                return const SliverFillRemaining(child: Text('Bilinmeyen bir hata oluştu!'));
              } else {
                return const SliverFillRemaining(child: Text('Bilinmeyen bir hata oluştu!'));
              }
            },
          )
        ],
      ),
    );
  }
}
