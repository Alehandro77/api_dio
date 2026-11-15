import 'package:api_dio/cubit/horoscope_state.dart';
import 'package:api_dio/services/horoscope_service.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

class HoroscopeCubit extends Cubit<HoroscopeState> {
  final _service = GetIt.instance<HoroscopeService>();

  HoroscopeCubit() : super(const HoroscopeState());

  Future<void> loadHoroscope() async {
    if (state.zodiac.isEmpty) return;
    emit(state.horoscopePath(isLoading: true, error: null));

    try {
      final horoscope = await _service.fetchHoroscope(state.zodiac);
      if (horoscope == null) {
        emit(
          state.horoscopePath(
            isLoading: false,
            error: 'Не удалось загрузить гороскоп (╥_╥)',
          ),
        );
      } else {
        emit(state.horoscopePath(isLoading: false, horoscope: horoscope));
      }
    } catch (e) {
      emit(state.horoscopePath(isLoading: false, error: 'Ошибка: $e'));
    }
  }

  void setZodiac(String zodiac) {
    if (zodiac == state.zodiac) return;
    emit(state.horoscopePath(zodiac: zodiac));
    loadHoroscope();
  }

  void setName(String name) {
    emit(state.horoscopePath(name: name));
  }
}
