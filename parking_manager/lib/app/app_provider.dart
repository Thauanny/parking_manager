import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/app_bloc.dart';
import 'config/shared_preferences_config.dart';
import 'features/home/home_provider.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharedPreferencesConfig =
        BlocProvider.of<SharedPreferencesConfig>(context);
    sharedPreferencesConfig.appSettings();

    return BlocProvider<AppBloc>(
        create: (context) =>
            AppBloc(sharedPreferencesConfig: sharedPreferencesConfig),
        child: const HomeProvider());
  }
}
