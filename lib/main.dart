import 'package:api_dio/screen/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'interseptors/login_interseptor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  setupService();
  runApp(const QuotesApp());
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
}

class QuotesApp extends StatelessWidget {
  const QuotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qoutes',
      home: Scaffold(
        appBar: AppBar(title: const Text('Гороскопчик UwU')),
        body: RootScreen(),
      ),
    );
  }
}
