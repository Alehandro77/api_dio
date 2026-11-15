import 'package:api_dio/cubit/horoscope_cubit.dart';
import 'package:api_dio/widgets/horoscope_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HoroscopeCubit>().loadHoroscope();
  }

  String _getAddress(String zodiac) {
    switch (zodiac) {
      case 'aries':
        return "Овнов";
      case 'taurus':
        return "Тельцов";
      case 'gemini':
        return "Близнецов";
      case 'cancer':
        return "Раков";
      case 'virgo':
        return "Дев";
      case 'libra':
        return "Весов";
      case 'scorpio':
        return "Скорпионов";
      case 'sagittarius':
        return "Стрельцоы";
      case 'capricorn':
        return "Козерогов";
      case 'aquarius':
        return "Водолеев";
      case 'pisces':
        return "Рыб";
      case 'leo':
        return "Львов";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HoroscopeCubit>().state;
    final address = _getAddress(state.zodiac);

    if (state.zodiac.isEmpty) {
      return const Center(child: Text("Выберте Знак Зодиака"));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          maxLines: 2,
          softWrap: true,
          "Привет ${state.name}, у $address сегодня такие вот дела:",
        ),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
          ? Center(child: Text(state.error!))
          : state.horoscope != null
          ? HoroscopeCard(horoscope: state.horoscope!)
          : const Center(child: Text("Чё-то не работает")),
    );
  }
}
