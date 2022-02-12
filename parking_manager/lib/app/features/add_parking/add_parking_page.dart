import 'package:flutter/material.dart';
import 'package:parking_manager/app/config/colors.dart';

import '../../shared/text_form_field_custom.dart';

class AddParkingPage extends StatelessWidget {
  const AddParkingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mainColor,
        title: const Text('Adicione um estacionamento'),
      ),
      body: ListView(
        children: const [
          TextFormFielDCustom(
              title1: 'Nome do estacionamento',
              hintText1: 'escreva aqui o nome do seu estacionamento',
              title2: 'Quantidade de vagas',
              hintText2: 'escreva aqui a quantidade de vagas',
              keyboardTypes: [TextInputType.name, TextInputType.number]),
        ],
      ),
    );
  }
}
