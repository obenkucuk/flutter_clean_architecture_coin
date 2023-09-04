import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_coin/core/formaters/formaters.dart';

class SingleListItem extends StatelessWidget {
  const SingleListItem({
    super.key,
    required this.color,
    required this.changePercent24Hr,
    this.name,
    this.symbol,
    this.volumeUsd24Hr,
    this.priceUsd,
    this.previousPrice,
  });

  final String? previousPrice;
  final String? name;
  final String? symbol;
  final String? volumeUsd24Hr;
  final String? priceUsd;
  final MaterialColor color;
  final double changePercent24Hr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '$name / $symbol',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  'Vol ${formatVolumeUsd24Hr(volumeUsd24Hr)}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  formatPrice(priceUsd),
                  textAlign: TextAlign.right,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(color: color, borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('%${changePercent24Hr.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
