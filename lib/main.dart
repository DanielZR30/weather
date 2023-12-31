import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:weather/Provider/services/location_service.dart';
import 'package:weather/Provider/services/weather_service.dart';
import 'package:weather/presentation/view/main_view.dart';
import 'package:weather/presentation/view/three_days_weather_view.dart';
import 'package:weather/presentation/view/today_weather_view.dart';
import 'package:weather/viewmodel/three_days_weather_viewmodel.dart';
import 'package:weather/viewmodel/today_weather_viewmodel.dart';
import 'model/domain/weather_model.dart';
import 'package:get_it/get_it.dart';

void setUp(){

}

void main() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<WeatherService>(WeatherService());
  getIt.registerSingleton<LocationService>(LocationService());
  getIt.registerSingleton<TodayWeatherViewModel>(TodayWeatherViewModel());
  getIt.registerSingleton<ThreeDaysWeatherViewModel>(ThreeDaysWeatherViewModel());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Color(0xffe96e50),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: Color(0xff2e2e2e),
            fontSize: 22.0,
            fontWeight: FontWeight.w600
          ),
          titleMedium: TextStyle(
              color: Color(0xff4e4e4e),
              fontSize: 18.0,
              fontWeight: FontWeight.w600
          ),
          titleSmall: TextStyle(
              color: Color(0xff4e4e4e),
              fontSize: 16.0,
              fontWeight: FontWeight.w500
          ),
          bodyLarge:
          TextStyle(
              color: Color(0xff4e4e4e),
              fontSize: 14.0,
              fontWeight: FontWeight.w400
          ),
          bodyMedium:
          TextStyle(
              color: Color(0xff4e4e4e),
              fontSize: 10.0,
              fontWeight: FontWeight.w400
          ),
        )
      ),
      initialRoute: "/weather",
      routes: {
        "/weather":(BuildContext context) => MainView(TodayWeatherView(),0),
        "/week":(BuildContext context) => MainView(ThreeDaysWeatherView(),1)
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Location location = new Location();

  void _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    print(_locationData.latitude.toString() + " " + _locationData.longitude.toString());
  }

  void _getWeatherData() async{
    var fetch = await fetchPost();
    print("weather: "+jsonDecode(fetch.body).toString());
  }

  Future<http.Response> fetchPost() {
    var uri = Uri.https('api.openweathermap.org','/data/2.5/weather',
        {'lat':'6.25184','lon':'-75.56359','lang':'es',
        'appid':'09c09d16add0d692539d39d53701650a','units':'metric'
        });
    return http.get(uri);
  }
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getWeatherData,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
