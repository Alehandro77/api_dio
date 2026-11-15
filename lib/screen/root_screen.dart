import 'package:api_dio/cubit/horoscope_cubit.dart';
import 'package:api_dio/screen/for_friend_screen.dart';
import 'package:api_dio/screen/main_screen.dart';
import 'package:api_dio/screen/profile_screen.dart';
import 'package:api_dio/screen/select_zodiac_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HoroscopeCubit>().state;

    if (state.zodiac.isEmpty) return const SelectZodiacScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Гороскопчик UwU",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [MainScreen(), ForFriendScreen(), ProfileScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Гороскоп"),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_emoticon_rounded),
            label: "Другу",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Профиль"),
        ],
      ),
    );
  }
}
