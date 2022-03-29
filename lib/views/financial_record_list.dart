import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/components/financial_records_tile.dart';
import 'package:flutter_crud/data/database.dart';
import 'package:flutter_crud/models/financial_record.dart';
import 'package:flutter_crud/providers/financial_record_provider.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class FinancialRecordList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double valorTotal = 0;

    final FinancialRecordProvider provider = Provider.of(context);

    DBProvider.db.financialRecords().then((value) => provider.setRegistros(value));

    if(provider!=null && provider.valorTotal !=null){
      valorTotal = provider.valorTotal;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Gastos"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.FINANCIAL_RECORD_FORM,
                    arguments: new FinancialRecord(
                        0, 0.0, ''));
              },
              icon: Icon(Icons.add)),
          IconButton(
              onPressed: () {
                print("Exportar para excel");
              },
              icon: Icon(Icons.import_export)),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.SETTINGS);
              },
              icon: Icon(Icons.settings)),

        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 180,
                child: ListTile(
                  leading: Icon(Icons.account_balance_wallet, color: Colors.blueAccent,),
                  title: Text("Total:"),
                  subtitle: Text(" $valorTotal BRL"),
                ),
              ),
              SizedBox(
                width: 200,
                child: DropdownButton<String>(
                  value: 'Dia',
                  icon: const Icon(Icons.list, color: Colors.blue,),
                  isExpanded: true,
                  elevation: 16,
                  style: const TextStyle(color: Colors.blue),
                  underline: Container(
                    height: 2,
                    color: Colors.blue,
                  ),
                  onChanged: (String? newValue) {
                    print(newValue);
                  },
                  items: <String>['Dia', 'Mês', 'Ano']
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
          Expanded(
              child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: provider.count,
              itemBuilder: (ctx, i) => FinancialRecordsTile(provider.byIndex(i)),
          )),
        ],
      ),
    );
  }
}
