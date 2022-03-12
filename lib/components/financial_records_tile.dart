import 'package:flutter/material.dart';
import 'package:flutter_crud/models/financial_record.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/providers/financial_record_provider.dart';
import 'package:flutter_crud/providers/users_providers.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class FinancialRecordsTile extends StatelessWidget {
  final FinancialRecord financialRecord;

  //construtor
  FinancialRecordsTile(this.financialRecord);

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(child: Icon(Icons.money));
    return ListTile(
      leading: avatar,
      title: Text(financialRecord.descricao ??=''),
      subtitle: Text(financialRecord.value.toString()+ ' BRL'),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.FINANCIAL_RECORD_FORM, arguments: financialRecord);
            }, icon: Icon(Icons.edit), color: Colors.orange,),
            IconButton(onPressed: () {
              showDialog(context: context, builder: (ctx) => AlertDialog(
                title: Text('Excluir Gasto'),
                content: Text('Tem certeza que deseja excluir o registro de valor ' + financialRecord.value.toString() + ' ?'),
                actions: [
                  TextButton(onPressed: () {
                    Provider.of<FinancialRecordProvider>(context, listen: false).remove(financialRecord);
                    Navigator.of(context).pop(true);
                  }, child: Text('Sim')),
                  TextButton(onPressed: () {
                    Navigator.of(context).pop(false);
                  }, child: Text('Não'))
                ],
              )).then((value) => print(value));

            }, icon: Icon(Icons.delete), color: Colors.red,),
          ],
        ),
      ),
    );
  }
}
