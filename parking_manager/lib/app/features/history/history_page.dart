import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/app/bloc/app_bloc.dart';
import 'package:parking_manager/app/config/colors.dart';
import 'package:parking_manager/app/features/add_car/model/cars.dart';
import 'package:parking_manager/app/features/add_parking/model/parking.dart';

import '../../shared/date_time_format.dart';

class HistoryPage extends StatelessWidget {
  final Parking parking;
  const HistoryPage({Key? key, required this.parking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    final _parking = appBloc.historyList
        .firstWhere((element) => element.name == parking.name);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Histórico'),
        backgroundColor: mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            return _parking.cars.isEmpty
                ? Center(
                    child: Text('vazio'),
                  )
                : ListView.builder(
                    itemCount: _parking.cars.length,
                    itemBuilder: (context, index) => _historyCards(
                        context: context, car: _parking.cars.elementAt(index)),
                  );
          },
        ),
      ),
    );
  }

  Widget _historyCards({required BuildContext context, required Car car}) {
    return InkWell(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 4,
        child: Card(
          color: mainColor,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Modelo e Cor: ' + car.modelAndColor,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        'Placa: ' + car.licensePlate,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        'Entrada: ' + dateTimeFormat(car.checkIn),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        'Saida: ' +
                            (car.checkOut != null
                                ? dateTimeFormat(car.checkIn)
                                : ''),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.history,
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
}
