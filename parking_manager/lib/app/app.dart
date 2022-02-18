import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/app/config/shared_preferences_config_parking.dart';
import 'app_provider.dart';
import 'config/shared_preferences_config_car.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharedPreferencesConfigParking = SharedPreferencesConfigParking();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CheckList',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<SharedPreferencesConfigParking>(
            create: (context) => sharedPreferencesConfigParking,
          ),
          BlocProvider<SharedPreferencesConfigCar>(
            create: (context) => SharedPreferencesConfigCar(
                sharedPreferencesConfigParking: sharedPreferencesConfigParking),
          ),
        ],
        child: const AppProvider(),
      ),
    );
  }
}
