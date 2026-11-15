import 'package:api_dio/models/horoscope_model.dart';
import 'package:api_dio/services/horoscope_service.dart';
import 'package:api_dio/widgets/horoscope_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ForFriendScreen extends StatefulWidget {
  const ForFriendScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ForFriendScreenState();
}

class _ForFriendScreenState extends State<ForFriendScreen> {
  String? _zodiac;
  Horoscope? _horoscope;
  bool _isLoading = false;
  final _service = GetIt.instance<HoroscopeService>();

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
      appBar: AppBar(
        title: Text(
          maxLines: 2,
          softWrap: true,
          "Посмотри Гороскоп для своего друга @w@",
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Знак Зодиака друга: ", style: TextStyle(fontSize: 18)),
              SizedBox(width: 15),
              DropdownButton<String>(
                underline: SizedBox(),
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
            ],
          ),
          const SizedBox(height: 20),
          _zodiac == null
              ? Center(
                  child: Text(
                    "Выберите Знак Зодиака друга",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              : _isLoading
              ? Center(child: CircularProgressIndicator())
              : _horoscope == null
              ? Center(
                  child: Text(
                    "Не удалось загрузить гороскоп (╥_╥)",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                )
              : Center(
                  child: Column(
                    children: [
                      Text(
                        "У ваше друга сегодня:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      HoroscopeCard(horoscope: _horoscope!),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
