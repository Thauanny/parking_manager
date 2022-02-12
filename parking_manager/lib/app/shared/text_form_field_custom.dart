import 'package:flutter/material.dart';

import '../config/colors.dart';

class TextFormFielDCustom extends StatefulWidget {
  final String hintText1;
  final String hintText2;
  final List<TextInputType> keyboardTypes;
  final String title1;
  final String title2;
  const TextFormFielDCustom(
      {required this.keyboardTypes,
      required this.hintText1,
      required this.hintText2,
      required this.title1,
      required this.title2});

  @override
  _TextFormFielDCustomState createState() => _TextFormFielDCustomState();
}

class _TextFormFielDCustomState extends State<TextFormFielDCustom> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Center(
                child: Text(
                  widget.title1,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: widget.hintText1,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: mainColor!),
                ),
              ),
              keyboardType: widget.keyboardTypes.elementAt(0),
              textAlign: TextAlign.center,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Text is empty';
                }
                return null;
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Center(
                child: Text(
                  widget.title2,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: widget.hintText2,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: mainColor!),
                ),
              ),
              keyboardType: widget.keyboardTypes.elementAt(1),
              textAlign: TextAlign.center,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Text is empty';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  fixedSize: const Size(250, 40),
                  primary: Colors.white,
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO submit
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
    );
  }
}
