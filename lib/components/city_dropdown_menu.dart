import 'package:flutter/material.dart';
import 'package:jakosc_powietrza/models/city_id.dart';

class CityDropdownMenu extends StatefulWidget {
  const CityDropdownMenu(
      {super.key, required this.futureCityID, required this.onCountrySelected});
  final List<CityID> futureCityID;
  final Function(String) onCountrySelected;

  @override
  State<CityDropdownMenu> createState() => _CityDropdownMenuState();
}

class _CityDropdownMenuState extends State<CityDropdownMenu> {
  late String currentValue;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: widget.futureCityID.first.id.toString(),
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
