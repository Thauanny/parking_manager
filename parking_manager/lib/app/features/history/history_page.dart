import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/app/bloc/app_bloc.dart';
import 'package:parking_manager/app/config/colors.dart';
import 'package:parking_manager/app/features/add_car/model/cars.dart';
import 'package:parking_manager/app/features/add_parking/model/parking.dart';

import '../../shared/date_time_format.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    final _cars = appBloc.historyList;
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
            return _cars.isEmpty
                ? Center(
                    child: Column(
                    children: [
                      Icon(
                        Icons.search_off_outlined,
                        size: 80,
                        color: mainColor,
                      ),
                      Text(
                        'Sem Carros',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                            fontSize: 20),
                        overflow: TextOverflow.clip,
                      )
                    ],
                  ))
                : ListView.builder(
                    itemCount: _cars.length,
                    itemBuilder: (context, index) => _historyCards(
                        context: context, car: _cars.elementAt(index)),
                  );
          },
        ),
      ),
    );
  }

  Widget _historyCards({required BuildContext context, required Car car}) {
    return InkWell(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3,
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
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Placa: ' + car.licensePlate,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                        overflow: TextOverflow.clip,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Entrada: ' + dateTimeFormat(car.checkIn),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                        overflow: TextOverflow.clip,
                      ),
                      const SizedBox(
                        height: 10,
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
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Local ' + car.parkingName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                        overflow: TextOverflow.clip,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Vaga ' + car.parkedIn.toString(),
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
