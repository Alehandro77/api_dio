import 'package:api_dio/cubit/friend_horoscope_cubit.dart';
import 'package:api_dio/widgets/horoscope_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForFriendScreen extends StatefulWidget {
  const ForFriendScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ForFriendScreenState();
}

class _ForFriendScreenState extends State<ForFriendScreen> {
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

  @override
  Widget build(BuildContext context) {
    final state = context.watch<FriendHoroscopeCubit>().state;

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
                underline: const SizedBox(),
                value: state.zodiac.isEmpty ? null : state.zodiac,
                items: _zodiacSigns.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.value,
                    child: Text(entry.key),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue == null) return;
                  context.read<FriendHoroscopeCubit>().setZodiac(newValue);
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (state.zodiac.isEmpty)
            const Center(
              child: Text(
                "Выберите знак зодиака друга",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          else if (state.isLoading)
            const Center(child: CircularProgressIndicator())
          else if (state.error != null)
            Center(
              child: Text(
                state.error!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            )
          else if (state.horoscope != null)
            Center(
              child: Column(
                children: [
                  const Text(
                    "У вашего друга сегодня:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  HoroscopeCard(horoscope: state.horoscope!),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
