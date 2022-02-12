import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_provider.dart';
import 'config/shared_preferences_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CheckList',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<SharedPreferencesConfig>(
        create: (context) => SharedPreferencesConfig(),
        child: const AppProvider(),
      ),
    );
  }
}
