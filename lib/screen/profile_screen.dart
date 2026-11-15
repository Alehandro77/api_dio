import 'package:api_dio/cubit/horoscope_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _currentName;
  late String _currentZodiac;

  final Map<String, String> _zodiacRu = {
    'aries': 'Овен',
    'taurus': 'Телец',
    'gemini': 'Близнецы',
    'cancer': 'Рак',
    'leo': 'Лев',
    'virgo': 'Дева',
    'libra': 'Весы',
    'scorpio': 'Скорпион',
    'sagittarius': 'Стрелец',
    'capricorn': 'Козерог',
    'aquarius': 'Водолей',
    'pisces': 'Рыбы',
  };

  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<HoroscopeCubit>().state;
    _currentName = state.name;
    _currentZodiac = state.zodiac;
    _nameController.text = _currentName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    final cubit = context.read<HoroscopeCubit>();
    _currentName = _nameController.text;
    cubit.setName(_currentName);
    cubit.setZodiac(_currentZodiac);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Профиль сохранен (⌐■_■)')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Профиль ( ˘ω˘ )')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ваш Знак Зодиака:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 15),
                DropdownButton<String>(
                  value: _currentZodiac,
                  items: _zodiacRu.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text(entry.value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _currentZodiac = newValue!;
                    });
                  },
                ),
              ],
            ),

            Text(
              'Имя: $_currentName',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Изменить имя: ',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
