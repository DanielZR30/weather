import 'package:flutter/material.dart';
import 'package:weather/Provider/services/weather_service.dart';
import 'package:weather/presentation/view/three_days_weather_view.dart';
import 'package:weather/presentation/view/today_weather_view.dart';
import 'package:weather/viewmodel/today_weather_viewmodel.dart';

class MainView extends StatefulWidget{

  final StatefulWidget page;
  int selectedPage;

  MainView (StatefulWidget this.page, int this.selectedPage, {super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final screens = [TodayWeatherView(),ThreeDaysWeatherView()];

    return Scaffold(
      body: widget.page,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.selectedPage,
        onTap: (index){
          setState(() {
            widget.selectedPage = index;
            Navigator.of(context).pushNamed(_getRouteName(index));
          });
        },
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny_outlined,color: Color(0xffeeeeee)),
            activeIcon: Icon(Icons.wb_sunny_rounded,color: Color(0xffeeeeee)),
            label: 'Today',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.thunderstorm_outlined,color: Color(0xffeeeeee) ),
              activeIcon: Icon(Icons.thunderstorm_rounded,color: Color(0xffeeeeee)),
              label: 'Week',
          )

        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  String _getRouteName(int index) {
    switch (index) {
      case 0:
        return '/weather';
      case 1:
        return '/week';
      default:
        return '/weather';
    }
  }
}