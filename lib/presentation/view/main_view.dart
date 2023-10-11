import 'package:flutter/material.dart';
import 'package:weather/presentation/view/three_days_weather_view.dart';
import 'package:weather/presentation/view/today_weather_view.dart';

class MainView extends StatefulWidget{
  const MainView ({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final screens = [TodayWeatherView(),ThreeDaysWeatherView()];

    return Scaffold(
      body: IndexedStack(
        index: selectedPage,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPage,
        onTap: (index){
          setState(() {
            selectedPage = index;
          });
        },
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny_outlined),
            activeIcon: Icon(Icons.wb_sunny_rounded),
            label: 'Today',
            backgroundColor: colors.primary
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.thunderstorm_outlined),
              activeIcon: Icon(Icons.thunderstorm_rounded),
              label: 'Week',
              backgroundColor: colors.primary
          )

        ],
      ),
    );
  }}