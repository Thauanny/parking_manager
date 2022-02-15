import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/app/bloc/app_bloc.dart';
import 'package:parking_manager/app/config/colors.dart';
import 'package:parking_manager/app/features/add_parking/model/parking.dart';

import '../../add_car/model/cars.dart';

class ParkingSpacePage extends StatelessWidget {
  final Parking parking;
  const ParkingSpacePage({Key? key, required this.parking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(parking.name),
        backgroundColor: mainColor,
      ),
      body: WillPopScope(
        onWillPop: () {
          appBloc.add(MakeAddInital());
          return Future.value(true);
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              if (state is RemoveCarFromParkingRemoving) {
                return Center(
                    child: CircularProgressIndicator(
                  color: mainColor,
                ));
              } else if (state is RemoveCarFromParkingError) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Falha ao remover carro,  tente novamente"),
                    ),
                  );
                });
                return gridViewCars(context: context, appBloc: appBloc);
              } else {
                return gridViewCars(context: context, appBloc: appBloc);
              }
            },
          ),
        ),
      ),
    );
  }

  Car? _returnCarOrFreeSpace({required int index}) {
    try {
      var car =
          parking.cars.firstWhere((element) => element.parkedIn == index + 1);

      return car;
    } catch (e) {
      return null;
    }
  }

  Widget gridViewCars(
          {required BuildContext context, required AppBloc appBloc}) =>
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
                                    var _parking = appBloc
                                        .sharedPreferencesConfig!.parkings
                                        .firstWhere((element) =>
                                            element.name == parking.name);
                                    appBloc.add(RemoveCarFromParking(
                                        index: _parking.cars.indexOf(car),
                                        parking: _parking));
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
