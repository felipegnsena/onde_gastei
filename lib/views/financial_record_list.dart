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
    final FinancialRecordProvider provider = Provider.of(context);

    //maneira de setar para não atualizar na interface nunca
    //final UsersProvider users = Provider.of(context, listen: false);

    DBProvider.db.financialRecords().then((value) => provider.setRegistros(value));

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
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.account_balance_wallet, color: Colors.red,),
            title: Text("Total:"),
            subtitle: Text("-100.00 BRL"),
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
