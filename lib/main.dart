import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/sensor_system/sensor_system.dart';
import 'providers/environmental_reading_provider.dart';
import 'providers/sensor_system_provider.dart';
import 'providers/unconv_api_provider.dart';
import 'screens/login.dart';
import 'screens/sensor_readings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => EnvironmentalReadingProvider()),
        ChangeNotifierProvider(create: (context) => SensorSystemProvider()),
        ChangeNotifierProvider(create: ((context) => UnconvApiProvider())),
      ],
      child: MaterialApp(
        onGenerateRoute: (settings) {
          if (settings.name == SensorReadings.routeName) {
            final args = settings.arguments as ScreenArguments;
            return MaterialPageRoute(
              builder: (context) {
                return SensorReadings(
                  selectedSensor: args.sensorSystem,
                );
              },
            );
          }
          return null;
        },
        title: 'Environment Monitor',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(
          title: 'Environment Monitor',
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class ScreenArguments {
  final SensorSystem sensorSystem;

  ScreenArguments(this.sensorSystem);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
