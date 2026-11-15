import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String zodiac;
  final String name;
  final void Function(String newName, String newZodiac) onSave;

  const ProfileScreen({
    super.key,
    required this.zodiac,
    required this.name,
    required this.onSave,
  });

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
    _currentName = widget.name;
    _currentZodiac = widget.zodiac;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _clearController() {
    _nameController.text = '';
  }

  void _saveProfile() {
    final name = _nameController.text;
    setState(() {
      _currentName = name;
    });
    widget.onSave(name, _currentZodiac);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Профиль сохранен')));
    _clearController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Профиль')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ваш знак зодиака: ${_zodiacRu[_currentZodiac]}'),
            Text('Имя: $_currentName'),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Введите ваше имя',
                border: OutlineInputBorder(),
              ),
            ),
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
