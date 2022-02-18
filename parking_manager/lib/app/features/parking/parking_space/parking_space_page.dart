import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parking_manager/app/config/colors.dart';
import 'package:parking_manager/app/features/parking/model/parking.dart';

import '../../car/bloc/car_bloc.dart';
import '../../car/model/car.dart';
import '../bloc/parking_bloc.dart';

class ParkingSpacePage extends StatelessWidget {
  final Parking parking;
  const ParkingSpacePage({Key? key, required this.parking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carBloc = BlocProvider.of<CarBloc>(context);

    final parkingBloc = BlocProvider.of<ParkingBloc>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(parking.name),
        backgroundColor: mainColor,
      ),
      body: WillPopScope(
        onWillPop: () {
          carBloc.add(MakeCarInital());
          parkingBloc.add(MakeParkingInital());
          return Future.value(true);
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: BlocBuilder<CarBloc, CarState>(
            builder: (context, state) {
              if (state is CarRemoveCarFromParkingRemoving) {
                return Center(
                    child: CircularProgressIndicator(
                  color: mainColor,
                ));
              } else if (state is CarRemoveCarFromParkingError) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Falha ao remover carro,  tente novamente"),
                    ),
                  );
                });
                return gridViewCars(
                    context: context,
                    carBloc: carBloc,
                    parkingBloc: parkingBloc);
              } else if (state is CarRemoveCarFromParkingRemoved) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                          "Vaga liberada com sucesso! Carro fez checkout!"),
                    ),
                  );
                });
                return gridViewCars(
                    context: context,
                    carBloc: carBloc,
                    parkingBloc: parkingBloc);
              } else {
                return gridViewCars(
                    context: context,
                    carBloc: carBloc,
                    parkingBloc: parkingBloc);
              }
            },
          ),
        ),
      ),
    );
  }

  Car? _returnCarOrFreeSpace({required int index}) {
    try {
      var car = parking.cars!.firstWhere((element) =>
          element.parkedIn == index + 1 && parking.name == element.parkingName);

      return car;
    } catch (e) {
      return null;
    }
  }

  Widget gridViewCars(
          {required BuildContext context,
          required CarBloc carBloc,
          required ParkingBloc parkingBloc}) =>
      GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height),
        ),
        itemCount: parking.coutParkingSpaces,
        itemBuilder: (context, index) {
          var car = _returnCarOrFreeSpace(index: index);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: mainColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Vaga ${index + 1}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          car != null
                              ? IconButton(
                                  onPressed: () {
                                    _showDialog(
                                        context: context,
                                        carBloc: carBloc,
                                        car: car,
                                        parking: parking,
                                        parkingBloc: parkingBloc);
                                  },
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                        width: 100,
                        child: Text(
                          car != null ? car.licensePlate : '',
                          style: const TextStyle(
                              overflow: TextOverflow.clip,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      car != null ? Icons.car_repair : Icons.crop_free_rounded,
                      color: Colors.white,
                      size: 100,
                      semanticLabel: 'Vaga livre',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 13.0, left: 8),
                    child: SizedBox(
                      width: 170,
                      child: Text(
                        car != null ? car.modelAndColor : 'Livre',
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}

void _showDialog(
    {required BuildContext context,
    required CarBloc carBloc,
    required Parking parking,
    required ParkingBloc parkingBloc,
    required Car car}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actions: <Widget>[
          _buttonOption(
              text: 'Liberar vaga e dar checkout para este carro',
              context: context,
              carBloc: carBloc,
              car: car,
              parking: parking,
              parkingBloc: parkingBloc),
          _buttonOption(
              text: 'Cancelar',
              context: context,
              carBloc: carBloc,
              car: car,
              parking: parking,
              parkingBloc: parkingBloc)
        ],
      );
    },
  );
}

Widget _buttonOption(
        {required String text,
        required BuildContext context,
        required CarBloc carBloc,
        required Parking parking,
        required ParkingBloc parkingBloc,
        required Car car}) =>
    InkWell(
      onTap: () {
        if (!text.contains('Cancelar')) {
          carBloc.add(CarRemoveCarFromParking(
              index: parking.cars!.indexOf(car), parking: parking));
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
                  width: 250,
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
