import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/app/config/colors.dart';
import 'package:parking_manager/app/features/add_parking/model/parking.dart';
import 'package:parking_manager/app/utils/enum_type_operation_form.dart';

import '../../bloc/app_bloc.dart';
import '../../shared/text_form_field_custom.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({Key? key}) : super(key: key);

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  String? _value = 'vazio';
  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Text('Adicionar um carro ao um estacionamento'),
        ),
        body: WillPopScope(
          onWillPop: () {
            appBloc.add(MakeAddInital());
            return Future.value(true);
          },
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 85, right: 85),
                child: DropdownButton<String>(
                  isExpanded: false,
                  hint: const Text('Escolha o estacionamento'),
                  value: _value == 'vazio' ? null : _value,
                  onChanged: (newValue) {
                    setState(() {
                      _value = newValue;
                    });
                  },
                  items: appBloc.sharedPreferencesConfig!.parkings
                      .map((Parking? value) {
                    return DropdownMenuItem<String>(
                      value: value!.name,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
              ),
              TextFormFielDCustom(
                  value: _value,
                  title1: 'Modelo e Cor do carro (Fusca - Branco)',
                  hintText1: 'escreva aqui a modelo e cor',
                  title2: 'Placa do carro',
                  hintText2: 'escreva aqui a placa do carro',
                  keyboardTypes: const [
                    TextInputType.name,
                    TextInputType.name,
                    TextInputType.number
                  ],
                  listNanme: appBloc.sharedPreferencesConfig!.parkings,
                  option: TypeOperationForm.addCar,
                  title3: 'Vaga em que o carro ficará',
                  hintText3: 'Escreva aqui a vaga em que esse carro ficará'),
            ],
          ),
        ));
  }
}
