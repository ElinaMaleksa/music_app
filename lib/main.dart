import 'package:flutter/material.dart';
import 'package:music_app/home/presentation/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music SaltPay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF816fe5),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF816fe5),
          secondary: const Color(0xFF9d8feb),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
