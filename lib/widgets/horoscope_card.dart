import 'package:api_dio/models/horoscope_model.dart';
import 'package:flutter/material.dart';

class HoroscopeCard extends StatelessWidget {
  final Horoscope horoscope;

  const HoroscopeCard({super.key, required this.horoscope});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                horoscope.sign,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                horoscope.date,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 32),
              Text(horoscope.text, style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
