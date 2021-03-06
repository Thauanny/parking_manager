import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/app_bloc.dart';
import '../config/colors.dart';

import '../features/car/bloc/car_bloc.dart';
import '../features/car/model/car.dart';
import '../features/parking/bloc/parking_bloc.dart';
import '../features/parking/model/parking.dart';
import '../utils/enum_type_operation_form.dart';
import '../utils/enum_value_text_option.dart';
import '../utils/is_parking_space_free.dart';

// ignore: must_be_immutable
class TextFormFielDCustom extends StatefulWidget {
  final String hintText1;
  final String hintText2;
  final List<TextInputType> keyboardTypes;
  final String title1;
  final String title2;
  final List<dynamic> listNanme;
  dynamic value;
  TypeOperationForm option;
  String? title3;
  String? hintText3;
  TextFormFielDCustom({
    this.value,
    required this.keyboardTypes,
    required this.hintText1,
    required this.hintText2,
    required this.title1,
    required this.title2,
    required this.listNanme,
    required this.option,
    this.title3,
    this.hintText3,
  });

  @override
  _TextFormFielDCustomState createState() => _TextFormFielDCustomState();
}

class _TextFormFielDCustomState extends State<TextFormFielDCustom> {
  String valueFirstInput = '';
  String valueSecondInput = '';
  String valueThirdInput = '';
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    final appBloc = BlocProvider.of<AppBloc>(context);
    appBloc.add(MakeAddInital());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final carBloc = BlocProvider.of<CarBloc>(context);
    final parkingBloc = BlocProvider.of<ParkingBloc>(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            parkingBloc.sharedPreferencesConfig!.parkings.isEmpty &&
                    widget.option != TypeOperationForm.addParking
                ? 'Adicione estacionamentos antes!'
                : widget.value == 'vazio'
                    ? 'Necessario escolher um estacionamento para o carro*'
                    : '',
            style: const TextStyle(color: Color.fromARGB(255, 223, 13, 9)),
          ),
          BlocBuilder<ParkingBloc, ParkingState>(
            builder: (context, state) {
              if (state is ParkingAddPakingToListAdded) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content:
                          Text("Estacionamento Salvo, adicione carros nele!"),
                    ),
                  );
                });
              } else if (state is ParkingAddPakingToListError) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                          "Falha ao adicionar Estacionamento, reveja as informa????es e tente novamente"),
                    ),
                  );
                });
              } else if (state is ParkingAddPakingToListErrorAlreadyExist) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                          "Falha ao adicionar estacionamento, estacionamento j?? existe, tente trocar o nome!"),
                    ),
                  );
                });
              }
              return BlocBuilder<CarBloc, CarState>(
                builder: (context, state) {
                  if (state is CarAddCarToParkingListAdded) {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text("Carro salvo no estacionamento"),
                        ),
                      );
                    });
                  } else if (state is CarAddCarToParkingListError) {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                              "Falha ao adicionar carro, reveja as informa????es e tente novamente"),
                        ),
                      );
                    });
                  }
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 50,
                        ),
                        _title(title: widget.title1),
                        _textFormField(
                            hintText: widget.hintText1,
                            textInputType: widget.keyboardTypes.elementAt(0),
                            valueTextOption: ValueTextOption.first),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                        ),
                        _title(title: widget.title2),
                        const SizedBox(
                          height: 10,
                        ),
                        _textFormField(
                            hintText: widget.hintText2,
                            textInputType: widget.keyboardTypes.elementAt(1),
                            valueTextOption: ValueTextOption.second),
                        widget.title3 != null
                            ? Column(
                                children: [
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                  ),
                                  _title(title: widget.title3!),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  _textFormField(
                                      hintText: widget.hintText3!,
                                      textInputType:
                                          widget.keyboardTypes.elementAt(2),
                                      valueTextOption: ValueTextOption.third),
                                ],
                              )
                            : Container(),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 10),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              fixedSize: const Size(320, 57),
                              primary: Colors.white,
                              backgroundColor: mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  widget.value != 'vazio') {
                                if (widget.option ==
                                    TypeOperationForm.addParking) {
                                  try {
                                    parkingBloc.add(
                                      ParkingAddPakingToList(
                                        parking: Parking(
                                            coutParkingSpaces:
                                                int.parse(valueSecondInput),
                                            name: valueFirstInput,
                                            cars: <Car>[]),
                                      ),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                            "Falha ao adicionar Estacionamento, reveja as informa????es e tente novamente"),
                                      ),
                                    );
                                  }
                                } else if (widget.option ==
                                    TypeOperationForm.addCar) {
                                  try {
                                    carBloc.add(
                                      CarAddCarToParkingList(
                                          car: Car(
                                              checkIn: DateTime.now(),
                                              modelAndColor: valueFirstInput,
                                              licensePlate: valueSecondInput,
                                              parkedIn:
                                                  int.parse(valueThirdInput),
                                              parkingName: widget.value),
                                          value: widget.value),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                            "Falha ao adicionar carro, reveja as informa????es e tente novamente"),
                                      ),
                                    );
                                  }
                                }
                              }
                            },
                            child: const Text(
                              'Salvar',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

  bool parkingPlaceDontExist = false;
  bool parkingPlaceOccupied = false;

  Widget _title({required String title}) => Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      );

  Widget _textFormField(
          {required String hintText,
          required TextInputType textInputType,
          required ValueTextOption valueTextOption}) =>
      TextFormField(
        onChanged: (value) {
          if (valueTextOption == ValueTextOption.first) valueFirstInput = value;
          if (valueTextOption == ValueTextOption.second) {
            valueSecondInput = value;
          }

          if (valueTextOption == ValueTextOption.third) {
            final parkingBloc = BlocProvider.of<ParkingBloc>(context);
            var parking = parkingBloc.sharedPreferencesConfig!.parkings
                .firstWhere((element) => element!.name == widget.value);
            if (value.isNotEmpty &&
                int.parse(value) <= parking!.coutParkingSpaces) {
              valueThirdInput = value;
              parkingPlaceDontExist = false;
            } else {
              parkingPlaceDontExist = true;
            }
          }
        },
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: mainColor!),
          ),
        ),
        keyboardType: textInputType,
        textAlign: TextAlign.center,
        validator: (text) {
          var parkingBloc = BlocProvider.of<ParkingBloc>(context);
          Parking? parking;
          if (valueTextOption == ValueTextOption.third) {
            parking = parkingBloc.sharedPreferencesConfig!.parkings
                .firstWhere((element) => element!.name == widget.value);
          }

          if (text == null || text.isEmpty) {
            return 'Insira uma informa????o';
          } else if (valueTextOption == ValueTextOption.third &&
              text.isNotEmpty &&
              parkingPlaceDontExist &&
              textInputType == TextInputType.number) {
            return 'Vaga nao existe nesse estacionamento';
          } else if (valueTextOption == ValueTextOption.third &&
              textInputType == TextInputType.number &&
              isParkingSpaceFree(parking!, text, widget.value)) {
            return 'Vaga j?? ocupada';
          } else if (textInputType == TextInputType.number &&
              int.parse(text) <= 0) {
            return 'As vagas come??am do numero 1';
          }
          return null;
        },
      );
}
