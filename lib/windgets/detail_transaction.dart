// ignore_for_file: deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class DetailTransaction extends StatefulWidget {
  final Function addTx;
  final Function editTx;
  final Transaction? transaction;

  DetailTransaction(this.addTx, this.editTx, this.transaction) {
    print(this.transaction?.title);
  }

  @override
  State<DetailTransaction> createState() => _DetailTransactionState();
}

class _DetailTransactionState extends State<DetailTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.utc(0);

  void submitData(Transaction? transaction) {
    if (_amountController.text.isEmpty) {
      return;
    }
    // final enteredid = _titleController.text;
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty ||
        enteredAmount <= 0 ||
        _selectedDate == DateTime.utc(0)) {
      return;
    }

    if (transaction == null) {
      widget.addTx(
        enteredTitle,
        enteredAmount,
        _selectedDate,
      );
    } else {
      transaction.amount = enteredAmount;
      transaction.date = _selectedDate;
      transaction.title = enteredTitle;
      widget.editTx(transaction);
    }

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    DetailTransaction detailTransaction = (context.widget as DetailTransaction);
    Transaction? transaction;
    if (detailTransaction.transaction != null) {
      transaction = detailTransaction.transaction as Transaction;
      _titleController.text = transaction.title;
      _amountController.text = transaction.amount.toString();
      _selectedDate = transaction.date;
    }
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController
                // onChanged: (val) {
                //   titleInput = val;
                // },
                ),
            TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number
                // onChanged: (val) => amountInput = val,
                ),
            Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == DateTime.utc(0)
                        ? 'no date choisen!'
                        : DateFormat.yMd().format(_selectedDate)),
                  ),
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _presentDatePicker,
                      child: Text('choose your data',
                          style: TextStyle(fontWeight: FontWeight.bold)))
                ],
              ),
            ),
            RaisedButton(
                child: transaction == null
                    ? Text('Add Transaction')
                    : Text('Edit Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () => {submitData(transaction)}),
          ],
        ),
      ),
    );
  }
}
