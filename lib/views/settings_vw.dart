import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/models/financial_record.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/providers/financial_record_provider.dart';
import 'package:flutter_crud/providers/users_providers.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SettingsForm extends StatefulWidget {
  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {};

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {

    TextStyle estiloCampo = TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey);

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.blue;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                      width: 150 ,
                      child: Text("Tamanho das letras:",style: estiloCampo,)
                  ),
                  SizedBox(
                    width: 200,
                    child: DropdownButton<String>(
                      value: '100%',
                      icon: const Icon(Icons.list, color: Colors.lightBlueAccent,),
                      isExpanded: true,
                      elevation: 16,
                      style: const TextStyle(color: Colors.lightBlueAccent),
                      underline: Container(
                        height: 2,
                        color: Colors.lightBlueAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _formData['tamanhoLetra'] = newValue!;
                        });
                      },
                      items: <String>['75%', '100%', '125%', '150%']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Modo Daltônico:",style: estiloCampo,),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
