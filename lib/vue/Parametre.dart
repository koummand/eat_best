import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() => runApp(const ParametreApp());

class ParametreApp extends StatelessWidget {
  const ParametreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Parametre(),
    );
  }
}

class Parametre extends StatefulWidget {
  const Parametre({super.key});

  @override
  State<Parametre> createState() => _StateParamettre();
}

class _StateParamettre extends State<Parametre> {
  final _formkey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formkey,
      child: Scaffold(
        appBar: AppBar(
           backgroundColor: const Color.fromARGB(142, 0, 0, 0),
           centerTitle: true,
           title: const Text('Settings',style: TextStyle(color:Colors.white ),),
        ),
        body: Column(children: [
          FormBuilderSwitch(
            name: 'switch',
            initialValue: false,
            activeColor:Colors.black ,
            title: const Text(
              'Dark theme',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            decoration: const InputDecoration(border: InputBorder.none),
          ),
          FormBuilderSlider(
            name: 'slide',
            initialValue: 50,
            max: 100,
            min: 0,
            activeColor: Colors.black,
            decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'Light level',
                labelStyle:
                    TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 25)),
          )
        ]),
      ),
    );
  }
}
