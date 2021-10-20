// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../windgets/transaction_list.dart';
import 'detail_transaction.dart';
import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // NewTransaction(_addNewTransaction),
        //  TransactionList(_userTransactions),
      ],
    );
  }
}
