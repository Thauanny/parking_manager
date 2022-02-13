import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/app/config/colors.dart';

import '../../bloc/app_bloc.dart';
import '../../shared/text_form_field_custom.dart';
import '../../utils/enum_type_operation_form.dart';

class AddParkingPage extends StatelessWidget {
  const AddParkingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: mainColor,
          title: const Text('Adicione um estacionamento'),
        ),
        body: WillPopScope(
          onWillPop: () {
            appBloc.add(MakeAddInital());
            return Future.value(true);
          },
          child: ListView(
            children: [
              TextFormFielDCustom(
                  title1: 'Nome do estacionamento',
                  hintText1: 'escreva aqui o nome do seu estacionamento',
                  title2: 'Quantidade de vagas',
                  hintText2: 'escreva aqui a quantidade de vagas',
                  keyboardTypes: const [
                    TextInputType.name,
                    TextInputType.number
                  ],
                  listNanme: appBloc.parkingLots,
                  option: TypeOperationForm.addParking),
            ],
          ),
        ));
  }
}
