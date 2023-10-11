import 'package:flutter/material.dart';

class TodayWeatherView extends StatefulWidget{

  @override
  State<TodayWeatherView> createState() => _TodayWeatherViewState();
}

class _TodayWeatherViewState extends State<TodayWeatherView> {
  @override
  Widget build(BuildContext context) {
    return(
      Scaffold(
        body: const Center(
          child: Text("En todays weather"),
        ),
      )
    );
  }
}