import 'package:api_dio/models/horoscope_model.dart';
import 'package:api_dio/services/horoscope_service.dart';
import 'package:api_dio/widgets/horoscope_card.dart';
import 'package:flutter/material.dart';

class ForFriendScreen extends StatefulWidget {
  const ForFriendScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ForFriendScreenState();
}

class _ForFriendScreenState extends State<ForFriendScreen> {
  String? _zodiac;
  Horoscope? _horoscope;
  bool _isLoading = false;
  final _service = HoroscopeService();
  final Map<String, String> _zodiacSigns = {
    'Овен': 'aries',
    'Телец': 'taurus',
    'Близнецы': 'gemini',
    'Рак': 'cancer',
    'Лев': 'leo',
    'Дева': 'virgo',
    'Весы': 'libra',
    'Скорпион': 'scorpio',
    'Стрелец': 'sagittarius',
    'Козерог': 'capricorn',
    'Водолей': 'aquarius',
    'Рыбы': 'pisces',
  };

  Future<void> _loadHoroscope(String zodiac) async {
    setState(() => _isLoading = true);
    final horoscope = await _service.fetchHoroscope(zodiac);
    setState(() {
      _horoscope = horoscope;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Посмотри Гороскоп для своего друга @w@")),
      body: Column(
        children: [
          DropdownButton<String>(
            value: _zodiac,
            items: _zodiacSigns.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.value,
                child: Text(entry.key),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _zodiac = newValue!;
              });
              _loadHoroscope(_zodiac!);
            },
          ),
          const SizedBox(height: 20),
          _zodiac == null
              ? Center(child: Text("Выберите ЗЗ друга"))
              : _isLoading
              ? Center(child: CircularProgressIndicator())
              : _horoscope == null
              ? Center(child: Text("не удалось загрузить гороскоп"))
              : Center(
                  child: Column(
                    children: [
                      Text("У ваше друга сегодня:"),
                      HoroscopeCard(horoscope: _horoscope!),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
