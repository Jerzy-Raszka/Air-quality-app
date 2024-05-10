import 'package:flutter/material.dart';
import 'package:jakosc_powietrza/models/choosen_city.dart';
import 'package:jakosc_powietrza/models/city_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 225, 240, 218),
        appBar: appBar(),
        body: Column(
          children: <Widget>[
            const ChoosenCity(
              boxColor: Colors.red,
              cityName: 'malaga',
            ),
            const ChoosenCity(
              boxColor: Colors.green,
              cityName: 'tikitaki',
            ),
            const ChoosenCity(
              boxColor: Colors.blue,
              cityName: 'i',
            ),
            const ChoosenCity(
              boxColor: Colors.yellow,
              cityName: 'kasztanki',
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                children: const <Widget>[
                  SizedBox(
                    width: 10,
                  ),
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 191, 216, 175),
              ),
              child: const Text(
                'Zmień lokalizacje',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {},
            ),
            const SizedBox(
              height: 10,
            )
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
      backgroundColor: const Color.fromARGB(255, 225, 240, 218),
      elevation: 0.0,
      centerTitle: true,
    );
  }
}
