import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/app/bloc/app_bloc.dart';
import 'package:parking_manager/app/config/colors.dart';

import '../parking_space/parking_space_provider.dart';

class ParkingSelectPage extends StatelessWidget {
  const ParkingSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: mainColor,
          title: const Text('Estacionamento Registrados'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            appBloc.parkingLots.isEmpty
                ? Center(
                    child: Column(
                    children: [
                      Icon(
                        Icons.search_off_outlined,
                        size: 80,
                        color: mainColor,
                      ),
                      Text(
                        'Sem estacionamentos',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                            fontSize: 20),
                        overflow: TextOverflow.clip,
                      )
                    ],
                  ))
                : SizedBox(
                    height: MediaQuery.of(context).size.height - 100,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: BlocBuilder<AppBloc, AppState>(
                          builder: (context, state) {
                        if (state is RemoveCarFromParkingRemoved) {
                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text("Estacionamento Removido"),
                              ),
                            );
                          });
                          return listOfParkings(appBloc: appBloc);
                        } else if (state is RemoveCarFromParkingError) {
                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                    "Estacionamento Falhou em ser Removido"),
                              ),
                            );
                          });
                          return listOfParkings(appBloc: appBloc);
                        } else {
                          return appBloc.parkingLots.isEmpty
                              ? Center(
                                  child: Column(
                                  children: [
                                    Icon(
                                      Icons.search_off_outlined,
                                      size: 80,
                                      color: mainColor,
                                    ),
                                    Text(
                                      'Sem estacionamentos',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: mainColor,
                                          fontSize: 20),
                                      overflow: TextOverflow.clip,
                                    )
                                  ],
                                ))
                              : listOfParkings(appBloc: appBloc);
                        }
                      }),
                    ),
                  ),
          ],
        ));
  }

  Widget listOfParkings({required AppBloc appBloc}) => ListView.builder(
      itemCount: appBloc.parkingLots.length,
      itemBuilder: (context, index) => InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ParkingSpaceProvider(
                      appBloc: appBloc,
                      parking: appBloc.parkingLots.elementAt(index)),
                ),
              );
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 10,
              width: MediaQuery.of(context).size.width - 50,
              child: Card(
                color: mainColor,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              appBloc.add(
                                RemoveParking(
                                  parking: appBloc.parkingLots.elementAt(index),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              appBloc.parkingLots.elementAt(index).name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.local_parking_rounded,
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
          ));
}
