import 'package:flutter/material.dart';
import 'package:AirQuality/components/main_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 166, 227, 233),
        appBar: appBar(),
        body: const MainData());
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Jakość powietrza',
        style: TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
      ),
      backgroundColor: const Color.fromARGB(255, 113, 201, 206),
      elevation: 0.0,
      centerTitle: true,
    );
  }
}
