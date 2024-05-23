
import 'package:flutter_dictionary/bloc/word_cubit.dart';
import 'package:flutter_dictionary/data/API/service.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final GetIt getIt = GetIt.instance;

void setUpLocator() {
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(
      client: getIt(),
    ),

  );
  getIt.registerLazySingleton<WordCubit>(() => WordCubit());
  getIt.registerLazySingleton<http.Client>(() => http.Client());

}
