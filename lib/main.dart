import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_coin/features/coin/presentation/pages/coin_info_screen.dart';
import 'package:flutter_clean_architecture_coin/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Coin Info',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CoinInfoScreen(),
    );
  }
}
