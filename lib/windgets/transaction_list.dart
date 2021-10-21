// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  final Function editTx;

  TransactionList(this.transactions, this.deleteTx, this.editTx);

  @override
  Widget build(BuildContext context) {
    return Container(
     
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'no transiction adde yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 100,
                    child: Image.asset(
                      'assents/images/io.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                      leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                                child: Text('\$${transactions[index].amount}')),
                          )),
                      title: Text(transactions[index].title),
                      subtitle: Text(
                          DateFormat.yMMMEd().format(transactions[index].date)),
                      trailing: Wrap(
                        spacing: 12,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => deleteTx(transactions[index].id),
                          ),
                          IconButton(
                              icon: Icon(Icons.edit),
                              color: Theme.of(context).hintColor,
                              onPressed: () {
                                editTx(context, transactions[index]);
                              }),
                        ],
                      )
                      // IconButton(
                      //   icon: Icon(Icons.delete),
                      //   color: Theme.of(context).errorColor,
                      //   onPressed: () => deleteTx(transactions[index].id),
                      // ),

                      ),
                );

                //  return Card(
                //   child: Row(
                //     children: <Widget>[
                //       Container(
                //         margin: EdgeInsets.symmetric(
                //           vertical: 10,
                //           horizontal: 15,
                //         ),
                //         decoration: BoxDecoration(
                //           border: Border.all(color: Colors.black, width: 2),
                //         ),
                //         padding: EdgeInsets.all(10),
                //         child: Text(
                //           '\$ ${transactions [index].amount.toStringAsFixed(2)}',
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 20,
                //             color: Colors.purple,
                //           ),
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: <Widget>[
                //           Text(transactions [index].title,
                //               style: Theme.of(context).textTheme.headline6
                //               ),

                //           Text(
                //             transactions [index].date.toString(),
                //             style: TextStyle(color: Colors.grey),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
