import 'package:api_dio/screen/for_friend_screen.dart';
import 'package:api_dio/screen/main_screen.dart';
import 'package:api_dio/screen/profile_screen.dart';
import 'package:api_dio/screen/select_zodiac_screen.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;
  String _zodiac = '';
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _zodiac.isEmpty
          ? SelectZodiacScreen(
              onZodiacSelected: (newZodiac) {
                setState(() => _zodiac = newZodiac);
              },
            )
          : IndexedStack(
              index: _currentIndex,
              children: [
                MainScreen(zodiac: _zodiac, name: _name),
                ForFriendScreen(),
                ProfileScreen(
                  zodiac: _zodiac,
                  name: _name,
                  onSave: (newName, newZodiac) {
                    setState(() {
                      _name = newName;
                      _zodiac = newZodiac;
                    });
                  },
                ),
              ],
            ),
      bottomNavigationBar: _zodiac.isEmpty
          ? null
          : BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() => _currentIndex = index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.star),
                  label: "Гороскоп",
                ),
                BottomNavigationBarItem(icon: Icon(Icons.star), label: "Другу"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Профиль",
                ),
              ],
            ),
    );
  }
}
