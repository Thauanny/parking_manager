import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app_bloc.dart';
import 'add_car_page.dart';

class AddCarProvider extends StatelessWidget {
  final AppBloc appBloc;
  const AddCarProvider({Key? key, required this.appBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
        create: (context) => appBloc, child: const AddCarPage());
  }
}
