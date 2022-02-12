import 'package:flutter/material.dart';
import 'package:parking_manager/app/config/colors.dart';

import '../../shared/text_form_field_custom.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({Key? key}) : super(key: key);

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  String? _value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('Adicionar um carro ao um estacionamento'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 85, right: 85),
            child: DropdownButton<String>(
              isExpanded: false,
              hint: Text('Escolha o estacionamento'),
              value: _value,
              onChanged: (newValue) {
                setState(() {
                  _value = newValue;
                });
              },
              items: <String>['A', 'B', 'C', 'D'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const TextFormFielDCustom(
              title1: 'Modelo e Cor do carro (Fusca - Branco)',
              hintText1: 'escreva aqui a modelo e cor',
              title2: 'Quantidade de vagas',
              hintText2: 'escreva aqui a quantidade de vagas',
              keyboardTypes: [TextInputType.name, TextInputType.name]),
        ],
      ),
    );
  }
}
