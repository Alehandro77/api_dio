import 'package:api_dio/cubit/friend_horoscope_cubit.dart';
import 'package:api_dio/cubit/horoscope_cubit.dart';
import 'package:api_dio/screen/root_screen.dart';
import 'package:api_dio/services/horoscope_service.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'interseptors/login_interseptor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  setupService();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.instance<HoroscopeCubit>()),
        BlocProvider(create: (_) => GetIt.instance<FriendHoroscopeCubit>()),
      ],
      child: const HoroscopeApp(),
    ),
  );
}

void setupService() {
  GetIt.instance.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://api.api-ninjas.com/v1/',
        headers: {'X-Api-Key': dotenv.env['API_KEY']!},
      ),
    )..interceptors.addAll([LogginInterseptor(), PrettyDioLogger()]),
  );
  GetIt.instance.registerLazySingleton<HoroscopeService>(
    () => HoroscopeService(),
  );
  GetIt.instance.registerLazySingleton<HoroscopeCubit>(() => HoroscopeCubit());
  GetIt.instance.registerLazySingleton<FriendHoroscopeCubit>(
    () => FriendHoroscopeCubit(),
  );
}

class HoroscopeApp extends StatelessWidget {
  const HoroscopeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const RootScreen());
  }
}
