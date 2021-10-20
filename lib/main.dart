// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lista/windgets/chart.dart';
import 'package:lista/windgets/head.dart';
import 'windgets/detail_transaction.dart';
import './windgets/transaction_list.dart';
import './models/transaction.dart';

// ignore: import_of_legacy_library_into_null_safe

void main() => runApp(MyApp());

// ignore: use_key_in_widget_constructors
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          errorColor: Colors.red,
          accentColor: Colors.amber,
          fontFamily: 'QuickSand',
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    button: TextStyle(color: Colors.white),
                  ))),
      home: MyHomePage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  // String title='';
  // String amountInput='';
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final titleController = TextEditingController();
  // final amountController = TextEditingController();
  final List<Transaction> _userTransactions = [
    Transaction(id: 't1', title: 'New Shos', amount: 10, date: DateTime.now()),
    // Transaction(
    //     id: 't1', title: 'old shose', amount: 8.59, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: txDate,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _editTransaction(Transaction transaction) {
    int transactionIndex =
        _userTransactions.indexWhere((tx) => tx.id == transaction.id);

    setState(() {
      _userTransactions[transactionIndex] = transaction;
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: DetailTransaction(_addNewTransaction, () => {}, null),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _startEditTransaction(BuildContext ctx, Transaction transaction) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: DetailTransaction(() => {}, _editTransaction, transaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'USED STORE',
        ),
        actions: <Widget>[IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Head(),
          Chart(_recentTransactions),
          TransactionList(
              _userTransactions, _deleteTransaction, _startEditTransaction),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
