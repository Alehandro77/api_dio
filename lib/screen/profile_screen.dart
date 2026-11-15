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
    _nameController.text = _currentName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    final String name = _nameController.text;
    setState(() {
      _currentName = name;
    });

    widget.onSave(name, _currentZodiac);
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
