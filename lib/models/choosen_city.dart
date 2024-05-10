import 'package:flutter/material.dart';

class ChoosenCity extends StatelessWidget {
  const ChoosenCity(
      {required this.boxColor, required this.cityName, super.key});
  final Color boxColor;
  final String cityName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Text(
            cityName,
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child: Container(
            width: 50,
            height: 18,
            color: boxColor,
          ),
        ),
      ],
    );
  }
}
