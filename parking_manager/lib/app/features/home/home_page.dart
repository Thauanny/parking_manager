import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/app/features/add_car/add_car_provider.dart';
import 'package:parking_manager/app/bloc/app_bloc.dart';
import '../../bloc/app_bloc.dart';

import '../../config/colors.dart';
import '../add_parking/add_parking_provider.dart';
import '../parking/parking_select/parking_select_provider.dart';
import '../parking/parking_space/parking_space_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Parking Manager',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
        backgroundColor: mainColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon(),
            _buttonsOptions(
                textLabel: 'Adicionar Estacionamento', option: 'addParkingLot'),
            _buttonsOptions(
                textLabel: 'Adicionar carro em uma vaga', option: 'addCar'),
            _buttonsOptions(
                textLabel: 'Verificar Vagas', option: 'checkParkingLot'),
            _buttonsOptions(
                textLabel: 'Ver Historico de Entrada e Saida',
                option: 'checkHistory'),
          ],
        ),
      ),
    );
  }

  Widget icon() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Image.asset(
          'assets/icon.jpg',
          fit: BoxFit.cover,
          height: 200,
          width: 200,
        ),
      ),
    );
  }

  Widget _buttonsOptions({required String textLabel, required String option}) {
    final appBloc = BlocProvider.of<AppBloc>(context);

    return InkWell(
      onTap: () {
        return checkRoute(context, option, appBloc);
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 9,
        width: MediaQuery.of(context).size.width - 50,
        child: Card(
          color: mainColor,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    textLabel,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      checkIcon(option),
                      color: Colors.white,
                      size: 35,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData checkIcon(String option) {
    switch (option) {
      case 'addCar':
        return Icons.car_repair;

      case 'addParkingLot':
        return Icons.local_parking_rounded;

      case 'checkParkingLot':
        return Icons.crop_free_rounded;

      case 'checkHistory':
        return Icons.history;

      default:
        return Icons.error;
    }
  }
}

void checkRoute(BuildContext context, String option, AppBloc appBloc) {
  switch (option) {
    case 'addCar':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddCarProvider(appBloc: appBloc),
        ),
      );
      break;
    case 'addParkingLot':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddParkingProvider(appBloc: appBloc),
        ),
      );
      break;
    case 'checkParkingLot':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParkingSelectProvider(appBloc: appBloc),
        ),
      );
      break;
    case 'checkHistory':
      break;
  }
}
