import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/app_bloc.dart';
import 'home_page.dart';

class HomeProvider extends StatelessWidget {
  final AppBloc appBloc;
  const HomeProvider({Key? key, required this.appBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
        create: (context) => appBloc, child: const HomePage());
  }
}