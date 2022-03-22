import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/models/financial_record.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/providers/financial_record_provider.dart';
import 'package:flutter_crud/providers/users_providers.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FinancialRecordForm extends StatefulWidget {
  @override
  State<FinancialRecordForm> createState() => _FinancialRecordFormState();
}

class _FinancialRecordFormState extends State<FinancialRecordForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {};

  void _loadFormData(FinancialRecord record) {
    _formData['id'] = record.id;
    _formData['descricao'] = record.descricao;
    _formData['value'] = record.value.toString();
    _formData['dataFormatada'] = record.creationDateValue?.substring(0,10);
    print(_formData['dataFormatada']);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final financialRecord =
        ModalRoute.of(context)!.settings.arguments as FinancialRecord;

    _loadFormData(financialRecord);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário de Gasto"),
        actions: [
          IconButton(
              onPressed: () {
                _form.currentState!.validate();
                _form.currentState!.save();
                _formData['isExpense'] = _formData['expensiveDropdown'] == 'Despesa' ? true : false;
                print(double.tryParse(_formData['value']));
                Provider.of<FinancialRecordProvider>(context, listen: false)
                    .put(new FinancialRecord(
                        _formData['id'],
                        double.tryParse(_formData['value']),
                        _formData['descricao']));
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
              TextFormField(
                initialValue: _formData['descricao'],
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null) {
                    return 'Campo descrição não pode ser nulo.';
                  }
                  return null;
                },
                onSaved: (value) => _formData['descricao'] = value!,
              ),
              TextFormField(
                initialValue: _formData['value'],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Value'),
                validator: (value) {
                  if (value == null) {
                    return 'Campo value não pode ser nulo.';
                  }
                  return null;
                },
                onSaved: (value) => _formData['value'] = value!,
              ),
              TextFormField(
                initialValue: _formData['dataFormatada'],
                decoration: InputDecoration(labelText: 'Data'),
                enabled: false,
              ),
              // DropdownButton<String>(
              //   value: _formData['expensiveDropdown'],
              //   icon: const Icon(Icons.arrow_downward),
              //   isExpanded: true,
              //   elevation: 16,
              //   style: const TextStyle(color: Colors.deepPurple),
              //   underline: Container(
              //     height: 2,
              //     color: Colors.deepPurpleAccent,
              //   ),
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       _formData['expensiveDropdown'] = newValue!;
              //     });
              //   },
              //   items: <String>['Despesa', 'Recebido']
              //       .map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
