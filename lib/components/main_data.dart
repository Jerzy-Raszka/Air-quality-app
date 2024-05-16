import 'package:flutter/material.dart';
import 'package:AirQuality/components/legend.dart';
import 'package:AirQuality/models/city_id.dart';
import 'package:AirQuality/components/choose_station_dialog.dart';
import 'package:AirQuality/components/choosen_city.dart';
import 'package:AirQuality/components/city_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MainData extends StatefulWidget {
  const MainData({
    super.key,
  });

  @override
  State<MainData> createState() => _MainDataState();
}

class _MainDataState extends State<MainData> {
  List<CityID> futureCityID = [];
  List<String> selectedCities = [];
  int startCityID = 52;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _distanceCalculation();
    _getStringValuesSF();
  }

  void _getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String firstCity = prefs.getString('0') ?? '114';
    String secondCity = prefs.getString('1') ?? '114';
    String thirdCity = prefs.getString('2') ?? '114';
    _onDialogSaved([firstCity, secondCity, thirdCity]);
    if (!mounted) return;
  }

  void _fetchData() async {
    final response = await http
        .get(Uri.parse('https://api.gios.gov.pl/pjp-api/rest/station/findAll'));
    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      setState(() {
        futureCityID =
            decodedJson.map<CityID>((item) => CityID.fromJson(item)).toList();
        futureCityID.sort((a, b) => a.stationName.compareTo(b.stationName));
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  void _distanceCalculation() async {
    Position position = await _determinePosition();
    double minDistance = 100;
    int i = 0;
    for (var d in futureCityID) {
      double distance = Geolocator.distanceBetween(
          position.latitude, position.longitude, d.gegrLat, d.gegrLon);
      if (i == 0) {
        startCityID = d.id;
        minDistance = distance;
      }
      if (distance < minDistance) {
        startCityID = d.id;
        minDistance = distance;
      }
      i++;
    }

    if (!mounted) return;
    setState(() {
      startCityID = startCityID;
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  void _onDialogSaved(List<String> cities) {
    setState(() {
      selectedCities = cities;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 5,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Najbliższa stacja: ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
              LegendButton(),
            ],
          ),
        ),
        ChoosenCity(
          cityId: '$startCityID',
          futureCityID: futureCityID,
        ),
        ...selectedCities.map((cityId) =>
            ChoosenCity(cityId: cityId, futureCityID: futureCityID)),
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              CityData(cityId: '$startCityID', futureCityID: futureCityID),
              ...selectedCities.map((cityId) => CityData(
                    cityId: cityId,
                    futureCityID: futureCityID,
                  )),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 113, 201, 206),
          ),
          child: const Text(
            'Zmień lokalizacje',
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          onPressed: () => showDialog<List<String>>(
            context: context,
            builder: (BuildContext context) => Dialog.fullscreen(
                child: ChooseStationDialog(
                    futureCityID: futureCityID, onDialogSaved: _onDialogSaved)),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
