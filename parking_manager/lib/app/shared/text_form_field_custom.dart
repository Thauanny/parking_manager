import 'package:flutter/material.dart';
import 'package:parking_manager/app/features/add_parking/model/parking.dart';

import '../config/colors.dart';
import '../features/add_car/model/cars.dart';

class TextFormFielDCustom extends StatefulWidget {
  final String hintText1;
  final String hintText2;
  final List<TextInputType> keyboardTypes;
  final String title1;
  final String title2;
  final List<dynamic> listNanme;
  dynamic value;
  String option;
  TextFormFielDCustom(
      {this.value,
      required this.keyboardTypes,
      required this.hintText1,
      required this.hintText2,
      required this.title1,
      required this.title2,
      required this.listNanme,
      required this.option});

  @override
  _TextFormFielDCustomState createState() => _TextFormFielDCustomState();
}

class _TextFormFielDCustomState extends State<TextFormFielDCustom> {
  String valueFirstInput = '';
  String valueSecondInput = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            widget.value == 'vazio'
                ? 'Necessario escolher um estacionamento para o carro*'
                : '',
            style: const TextStyle(color: Color.fromARGB(255, 223, 13, 9)),
          ),
          Form(
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
                  height: MediaQuery.of(context).size.height / 5,
                ),
                _title(title: widget.title2),
                const SizedBox(
                  height: 10,
                ),
                _textFormField(
                    hintText: widget.hintText2,
                    textInputType: widget.keyboardTypes.elementAt(1),
                    valueTextOption: 'second'),
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
                        if (widget.option == 'addParking') {
                          try {
                            widget.listNanme.add(
                              Parking(
                                  coutParkingSpaces:
                                      int.parse(valueSecondInput),
                                  name: valueFirstInput,
                                  cars: <Cars>[]),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                    "Estacionamento Salvo, adicione carros nele!"),
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
          ),
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
