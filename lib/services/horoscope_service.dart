import 'package:api_dio/models/horoscope_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final service = GetIt.instance;

class HoroscopeService {
  Future<Horoscope?> fetchHoroscope(String zodiac) async {
    try {
      final response = await service<Dio>().get(
        '/horoscope',
        queryParameters: {'zodiac': zodiac},
      );

      final Map<String, dynamic> data = response.data as Map<String, dynamic>;
      final Horoscope horoscope = Horoscope.fromJson(data);
      return horoscope;
    } on DioException catch (e) {
      print("Ошибка API: ${e.message}");
      if (e.response != null) {
        print('Статус: ${e.response?.statusCode}');
        print('Тело: ${e.response?.data}');
      }
      return null;
    } catch (e) {
      print("Ваще неожиданная оибка: $e");
      return null;
    }
  }
}
