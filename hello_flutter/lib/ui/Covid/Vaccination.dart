import 'package:flutter/material.dart';

class Vaccination extends StatefulWidget {

  @override
  _VaccinationState createState() => _VaccinationState();
}

class _VaccinationState extends State<Vaccination> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Vaccination')
      ),
    );
  }
}