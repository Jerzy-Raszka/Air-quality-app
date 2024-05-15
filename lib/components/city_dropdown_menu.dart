import 'package:flutter/material.dart';
import 'package:jakosc_powietrza/models/city_id.dart';

class CityDropdownMenu extends StatefulWidget {
  const CityDropdownMenu(
      {super.key,
      required this.futureCityID,
      required this.onCountrySelected,
      required this.initialId});
  final List<CityID> futureCityID;
  final Function(String) onCountrySelected;
  final String initialId;

  @override
  State<CityDropdownMenu> createState() => _CityDropdownMenuState();
}

class _CityDropdownMenuState extends State<CityDropdownMenu> {
  late String currentValue;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      width: MediaQuery.of(context).size.width - 10,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 113, 201, 206),
      ),
      initialSelection: widget.initialId,
      menuStyle: MenuStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          return const Color.fromARGB(255, 166, 227, 233);
        }),
      ),
      onSelected: (String? value) {
        setState(() {
          currentValue = value!;
        });
        widget.onCountrySelected(value!);
      },
      dropdownMenuEntries:
          widget.futureCityID.map<DropdownMenuEntry<String>>((CityID value) {
        return DropdownMenuEntry<String>(
            value: value.id.toString(), label: value.stationName);
      }).toList(),
    );
  }
}
