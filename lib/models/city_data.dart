import 'package:flutter/material.dart';

class CityData extends StatelessWidget {
  const CityData({required this.cityName, super.key});
  final String cityName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color.fromARGB(255, 138, 67, 91),
        ),
        width: 340,
        child: Center(
            child: Text(
          'Nazwa miejscowości: $cityName',
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
