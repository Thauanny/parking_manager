import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/app/config/colors.dart';
import 'package:parking_manager/app/features/car/model/car.dart';

import '../../../utils/date_time_format.dart';
import '../bloc/car_bloc.dart';

class CarHistoryPage extends StatelessWidget {
  const CarHistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carAppBloc = BlocProvider.of<CarBloc>(context);
    final _cars = carAppBloc.sharedPreferencesConfig!.history;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _showDialog(context, carAppBloc);
            },
            icon: const Icon(Icons.delete_forever, color: Colors.white),
          )
        ],
        centerTitle: true,
        title: const Text('Histórico'),
        backgroundColor: mainColor,
      ),
      body: WillPopScope(
        onWillPop: () {
          carAppBloc.add(MakeCarInital());
          return Future.value(true);
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocBuilder<CarBloc, CarState>(
            builder: (context, state) {
              if (state is CarClearHistorySucess) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Carros que já sairam foram removidos!"),
                    ),
                  );
                });
                return listOfCards(cars: _cars);
              } else if (state is CarClearHistoryError) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Historico nao pode ser removido"),
                    ),
                  );
                });
                return listOfCards(cars: _cars);
              } else {
                return listOfCards(cars: _cars);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget listOfCards({required List<Car> cars}) => cars.isEmpty
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
                  fontWeight: FontWeight.bold, color: mainColor, fontSize: 20),
              overflow: TextOverflow.clip,
            )
          ],
        ))
      : ListView.builder(
          itemCount: cars.length,
          itemBuilder: (context, index) =>
              _historyCards(context: context, car: cars.elementAt(index)),
        );

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
                        'Entrada: ' + dateTimeFormatToString(car.checkIn),
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
                                ? dateTimeFormatToString(car.checkIn)
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

  void _showDialog(BuildContext context, CarBloc carBloc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            _buttonOption("Apagar tudo", context, carBloc),
            _buttonOption(
                "Apagar somentes os que ja fizeram checkout", context, carBloc)
          ],
        );
      },
    );
  }
}

Widget _buttonOption(String text, BuildContext context, CarBloc carBloc) =>
    InkWell(
      onTap: () {
        if (text.contains("tudo")) {
          carBloc.add(CarClearHistory());
        } else {
          carBloc.add(CarClearCheckoutHistory());
        }
        Navigator.pop(context);
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 9,
        width: MediaQuery.of(context).size.width - 50,
        child: Card(
          color: mainColor,
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    text,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 19),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
