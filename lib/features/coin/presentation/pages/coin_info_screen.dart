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
  BlocProvider<CoinInfoBloc> build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<CoinInfoBloc>(),
      child: Scaffold(
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
            Builder(builder: (context) {
              return SliverRefreshWidget(
                onRefresh: () => Future.wait([context.read<CoinInfoBloc>().getCoinInfo(true)]),
                isRefreshing: true,
              );
            }),
            BlocBuilder<CoinInfoBloc, CoinInfoState>(
              builder: (context, state) {
                if (state.status == CoinInfoStatus.loading) {
                  return const SliverFillRemaining(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state.status == CoinInfoStatus.loaded || state.status == CoinInfoStatus.refresh) {
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
                          name: state.status.name,
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
      ),
    );
  }
}
