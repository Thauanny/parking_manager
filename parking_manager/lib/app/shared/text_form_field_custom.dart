import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/app/features/add_parking/model/parking.dart';

import '../bloc/app_bloc.dart';
import '../config/colors.dart';
import '../features/add_car/model/cars.dart';
import '../utils/enum_type_operation_form.dart';

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
  TextFormFielDCustom(
      {this.value,
      required this.keyboardTypes,
      required this.hintText1,
      required this.hintText2,
      required this.title1,
      required this.title2,
      required this.listNanme,
      required this.option,
      this.title3,
      this.hintText3});

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
  }

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            appBloc.parkingLots.isEmpty &&
                    widget.option != TypeOperationForm.addParking
                ? 'Adicione estacionamentos antes!'
                : widget.value == 'vazio'
                    ? 'Necessario escolher um estacionamento para o carro*'
                    : '',
            style: const TextStyle(color: Color.fromARGB(255, 223, 13, 9)),
          ),
          BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              if (state is AddPakingToListAdded) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content:
                          Text("Estacionamento Salvo, adicione carros nele!"),
                    ),
                  );
                });
              } else if (state is AddPakingToListError) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                          "Falha ao adicionar Estacionamento, reveja as informações e tente novamente"),
                    ),
                  );
                });
              } else if (state is AddCarToParkingListAdded) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Carro salvo no estacionamento"),
                    ),
                  );
                });
              } else if (state is AddCarToParkingListError) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                          "Falha ao adicionar carro, reveja as informações e tente novamente"),
                    ),
                  );
                });
              } else if (state is AddPakingToListErrorAlreadyExist) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                          "Falha ao adicionar estacionamento, estacionamento já existe, tente trocar o nome!"),
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
                        valueTextOption: 'first'),
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
                        valueTextOption: 'second'),
                    widget.title3 != null
                        ? Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 10,
                              ),
                              _title(title: widget.title3!),
                              const SizedBox(
                                height: 10,
                              ),
                              _textFormField(
                                  hintText: widget.hintText3!,
                                  textInputType:
                                      widget.keyboardTypes.elementAt(2),
                                  valueTextOption: 'third'),
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
                            if (widget.option == TypeOperationForm.addParking) {
                              try {
                                appBloc.add(
                                  AddPakingToList(
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
                                        "Falha ao adicionar Estacionamento, reveja as informações e tente novamente"),
                                  ),
                                );
                              }
                            } else if (widget.option ==
                                TypeOperationForm.addCar) {
                              try {
                                appBloc.add(
                                  AddCarToParkingList(
                                      car: Car(
                                          checkIn: DateTime.now(),
                                          modelAndColor: valueFirstInput,
                                          licensePlate: valueSecondInput,
                                          parkedIn: int.parse(valueThirdInput),
                                          parkingName: widget.value),
                                      value: widget.value),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                        "Falha ao adicionar carro, reveja as informações e tente novamente"),
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
          )
        ],
      ),
    );
  }

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
          required String valueTextOption}) =>
      TextFormField(
        onChanged: (value) {
          if (valueTextOption == 'first') valueFirstInput = value;
          if (valueTextOption == 'second') valueSecondInput = value;
          if (valueTextOption == 'third') valueThirdInput = value;
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
          if (text == null || text.isEmpty) {
            return 'Text is empty';
          }
          return null;
        },
      );
}
