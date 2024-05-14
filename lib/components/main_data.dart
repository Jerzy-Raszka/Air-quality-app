import 'package:flutter/material.dart';
import 'package:jakosc_powietrza/models/city_id.dart';
import 'package:jakosc_powietrza/components/choose_station_dialog.dart';
import 'package:jakosc_powietrza/components/choosen_city.dart';
import 'package:jakosc_powietrza/components/city_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'dart:developer' as developer;

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
    //TODO Load selectedCities from memory if wanted
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
            backgroundColor: const Color.fromARGB(255, 191, 216, 175),
          ),
          child: const Text(
            'Zmień lokalizacje',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
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
