import 'package:flutter/material.dart';
import 'package:jakosc_powietrza/models/main_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 225, 240, 218),
        appBar: appBar(),
        body: const MainData());
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Jakość powietrza',
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      backgroundColor: const Color.fromARGB(255, 55, 112, 28),
      elevation: 0.0,
      centerTitle: true,
    );
  }
}
