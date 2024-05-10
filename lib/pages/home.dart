import 'package:flutter/material.dart';
import 'package:jakosc_powietrza/models/choosen_city.dart';
import 'package:jakosc_powietrza/models/city_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: Column(
          children: <Widget>[
            const ChoosenCity(
              boxColor: Color.fromARGB(255, 172, 153, 153),
              cityName: 'malaga',
            ),
            const ChoosenCity(
              boxColor: Color.fromARGB(255, 17, 192, 31),
              cityName: 'tikitaki',
            ),
            const ChoosenCity(
              boxColor: Color.fromARGB(255, 18, 8, 153),
              cityName: 'i',
            ),
            const ChoosenCity(
              boxColor: Color.fromARGB(255, 187, 24, 24),
              cityName: 'kasztanki',
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                children: const <Widget>[
                  CityData(
                    cityName: 'malaga',
                  ),
                  CityData(cityName: 'tikitaki'),
                  CityData(
                    cityName: 'i',
                  ),
                  CityData(
                    cityName: 'kasztanki',
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Jakość powietrza',
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
    );
  }
}
