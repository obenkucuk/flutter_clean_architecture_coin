import 'package:intl/intl.dart';

String formatPrice(String? priceUsd) {
  return NumberFormat.currency(
    locale: 'en_US',
    decimalDigits: double.parse(priceUsd ?? '0.0') > 0.01 ? 2 : 8,
    name: '\$ ',
  ).format(double.parse(priceUsd ?? '0.0'));
}

String formatVolumeUsd24Hr(String? volumeUsd24Hr) {
  return NumberFormat.compactSimpleCurrency(locale: 'en_US', decimalDigits: 2, name: '\$ ').format(
    double.parse(volumeUsd24Hr ?? '0.0'),
  );
}
