import 'package:api_dio/models/horoscope_model.dart';

class FriendHoroscopeState {
  final String zodiac;
  final Horoscope? horoscope;
  final bool isLoading;
  final String? error;

  const FriendHoroscopeState({
    this.zodiac = '',
    this.horoscope,
    this.isLoading = false,
    this.error,
  });

  FriendHoroscopeState horoscopePath({
    String? zodiac,
    Horoscope? horoscope,
    bool? isLoading,
    String? error,
  }) {
    return FriendHoroscopeState(
      zodiac: zodiac ?? this.zodiac,
      horoscope: horoscope ?? this.horoscope,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
