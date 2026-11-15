import 'package:api_dio/models/horoscope_model.dart';

class HoroscopeState {
  final String zodiac;
  final String name;
  final Horoscope? horoscope;
  final bool isLoading;
  final String? error;

  const HoroscopeState({
    this.zodiac = '',
    this.name = 'Имя',
    this.horoscope,
    this.isLoading = false,
    this.error,
  });

  HoroscopeState horoscopePath({
    String? zodiac,
    String? name,
    Horoscope? horoscope,
    bool? isLoading,
    String? error,
  }) {
    return HoroscopeState(
      zodiac: zodiac ?? this.zodiac,
      name: name ?? this.name,
      horoscope: horoscope ?? this.horoscope,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
