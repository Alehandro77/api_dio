import 'package:api_dio/models/horoscope_model.dart';
import 'package:api_dio/widgets/horoscope_card.dart';
import 'package:flutter/material.dart';

import '../services/horoscope_service.dart';

class MainScreen extends StatefulWidget {
  final String zodiac;
  final String name;

  const MainScreen({super.key, required this.zodiac, required this.name});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _service = HoroscopeService();
  Horoscope? _horoscope;
  bool _isLoading = false;
  late String _address;

  void _loadAddress() {
    String address = "aries";
    switch (widget.zodiac) {
      case 'aries':
        address = "Овнов";
      case 'taurus':
        address = "Тельцов";
      case 'gemini':
        address = "Близнецов";
      case 'cancer':
        address = "Раков";
      case 'virgo':
        address = "Дев";
      case 'libra':
        address = "Весов";
      case 'scorpio':
        address = "Скорпионов";
      case 'sagittarius':
        address = "Стрельцоы";
      case 'capricorn':
        address = "Козерогов";
      case 'aquarius':
        address = "Водолеев";
      case 'pisces':
        address = "Рыб";
      case 'leo':
        address = "Львов";
    }
    setState(() => _address = address);
  }

  @override
  void initState() {
    super.initState();
    _loadHoroscope(widget.zodiac);
    _loadAddress();
  }

  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.zodiac != widget.zodiac) {
      _loadHoroscope(widget.zodiac);
      _loadAddress();
    }
  }

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
          "Привет ${widget.name}, у $_address сегодня такие вот дела:",
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _horoscope == null
          ? const Center(child: Text("Не удалось загрузить гороскоп"))
          : HoroscopeCard(horoscope: _horoscope!),
    );
  }
}
