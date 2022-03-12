import 'package:flutter/material.dart';
import 'package:flutter_crud/data/database.dart';
import 'package:flutter_crud/data/dummy_finantial_records.dart';
import 'package:flutter_crud/providers/financial_record_provider.dart';
import 'package:flutter_crud/providers/users_providers.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:flutter_crud/views/financial_record_form.dart';
import 'package:flutter_crud/views/financial_record_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {

    DUMMY_FINANTIAL_RECORDS.forEach((element) {DBProvider.db.insertFinancialRecord(element);});

    print("total de registros financeiros");
    DBProvider.db.financialRecords().then((value) => print(value.length));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UsersProvider()),
        ChangeNotifierProvider(create: (context) => FinancialRecordProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FinancialRecordList(),
        routes: {
          AppRoutes.FINANCIAL_RECORD_FORM: (_) => FinancialRecordForm()
        },
      ),
    );
  }
}

