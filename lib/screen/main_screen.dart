import 'package:api_dio/models/horoscope_model.dart';
import 'package:api_dio/widgets/horoscope_card.dart';
import 'package:flutter/material.dart';

import '../services/horoscope_service.dart';

class MainScreen extends StatefulWidget {
  final String zodiac;

  const MainScreen({super.key, required this.zodiac});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _service = HoroscopeService();
  Horoscope? _horoscope;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadHoroscope(widget.zodiac);
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
      appBar: AppBar(title: const Text("Мой гараскоп")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _horoscope == null
          ? const Center(child: Text("Не удалось загрузить гороскоп"))
          : HoroscopeCard(horoscope: _horoscope!),
    );
  }
}
