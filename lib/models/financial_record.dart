import 'package:flutter_crud/models/generic/generic_entity.dart';

class FinancialRecord{

  int? id;
  String? creationDateValue;
  int? changeDateValue;
  double? value;
  String? descricao;

  FinancialRecord(int id,this.value, this.descricao){

    this.id = id;

    this.creationDateValue = DateTime.now().toString();

  }


  FinancialRecord.jaCriado(
      this.id,
      this.creationDateValue,
      this.changeDateValue,
      this.value,
      this.descricao);

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
      'descricao': descricao,
      'creationDateValue':creationDateValue,
      'changeDateValue':changeDateValue
    };
  }
}