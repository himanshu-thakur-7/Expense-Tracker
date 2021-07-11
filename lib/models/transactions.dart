import 'package:flutter/foundation.dart';

class Transaction {
  String id, title;
  DateTime date;
  double amount;
  Transaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});
}
