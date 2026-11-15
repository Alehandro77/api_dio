import 'package:api_dio/cubit/horoscope_cubit.dart';
import 'package:api_dio/widgets/zodiac_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectZodiacScreen extends StatefulWidget {
  const SelectZodiacScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SelectZodiacScreen();
}

class _SelectZodiacScreen extends State<SelectZodiacScreen> {
  final List<String> _zodiacs = [
    "aries",
    "taurus",
    "gemini",
    "cancer",
    "leo",
    "virgo",
    "libra",
    "scorpio",
    "sagittarius",
    "capricorn",
    "aquarius",
    "pisces",
  ];

  void _onZodiacSelected(String zodiac) {
    context.read<HoroscopeCubit>().setZodiac(zodiac);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Выберите свой Знак Зодиака")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.5,
          ),
          itemCount: _zodiacs.length,
          itemBuilder: (context, index) {
            final zodiac = _zodiacs[index];
            return ZodiacButton(
              zodiac: zodiac,
              onPressed: () => _onZodiacSelected(zodiac),
            );
          },
        ),
      ),
    );
  }
}
