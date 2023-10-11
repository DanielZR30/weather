import 'package:flutter/material.dart';

class ThreeDaysWeatherView extends StatefulWidget{

  @override
  State<ThreeDaysWeatherView> createState() => _ThreeDaysWeatherViewState();
}

class _ThreeDaysWeatherViewState extends State<ThreeDaysWeatherView> {
  @override
  Widget build(BuildContext context) {
    return(
        Scaffold(
          body: const Center(
            child: Text("En Threendays weather"),
          ),
        )
    );
  }
}