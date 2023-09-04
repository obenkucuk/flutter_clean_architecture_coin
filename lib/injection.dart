import 'package:flutter_clean_architecture_coin/features/coin/data/datasources/coin_info_local_data_source.dart';
import 'package:flutter_clean_architecture_coin/features/coin/data/datasources/coin_info_remote_data_source.dart';
import 'package:flutter_clean_architecture_coin/features/coin/data/repositories/coin_infos_repositories.dart';
import 'package:flutter_clean_architecture_coin/features/coin/domain/repositories/i_coin_info_repositories.dart';
import 'package:flutter_clean_architecture_coin/features/coin/domain/usecases/coin_info_use_case.dart';
import 'package:flutter_clean_architecture_coin/features/coin/presentation/bloc/coin_info_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => CoinInfoBloc(getAllCoinInfo: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllCoinInfo(coinInfoRepository: sl()));

  // Repository
  sl.registerLazySingleton<ICoinInfoRepository>(
      () => CoinInfoRepository(coinInfoLocalDataSource: sl(), coinInfoRemoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<ICoinInfoRemoteDataSource>(
    () => CoinInfoRemoteDataSource(client: sl()),
  );

  sl.registerLazySingleton<ICoinInfoLocalDataSource>(
    () => CoinInfoLocalDataSource(sharedPreferences: sl()),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}
