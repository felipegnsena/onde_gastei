
import 'package:flutter_crud/models/financial_record.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {

  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database? _database;

  Future<Database> get database async =>
      _database ??= await initDB();


  initDB() async {
    print("iniciando base de dados");
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE finantial_records(id INTEGER PRIMARY KEY,  value REAL, descricao TEXT, creationDateValue INTEGER, changeDateValue INTEGER)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  // Define a function that inserts dogs into the database
  Future<void> insertFinancialRecord(FinancialRecord financialRecord) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'finantial_records',
      financialRecord.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<FinancialRecord>> financialRecords() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('finantial_records');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return FinancialRecord.jaCriado(
        maps[i]['id'],
        maps[i]['creationDateValue'],
        maps[i]['changeDateValue'],
        maps[i]['value'],
        maps[i]['descricao']
      );
    });
  }


  // A method that retrieves all the dogs from the dogs table.
  Future<FinancialRecord> financialByIndex(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('finantial_records',where: 'id=?', whereArgs: [id], limit: 1);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return FinancialRecord.jaCriado(
          maps[i]['id'],
          maps[i]['creationDateValue'],
          maps[i]['changeDateValue'],
          maps[i]['value'],
          maps[i]['descricao']
      );
    }).first;
  }



}
