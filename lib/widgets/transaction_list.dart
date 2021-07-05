import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(Transaction) deletetx;
  TransactionList({required this.transactions, required this.deletetx});
  @override
  Widget build(BuildContext context) {
    return transactions.isNotEmpty
        ? ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 3.0,
                margin: EdgeInsets.all(5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: FittedBox(
                        child: Text(
                            '₹${transactions[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(fontFamily: 'Quicksand')),
                      ),
                    ),
                  ),
                  title: Text(transactions[index].title,
                      style: Theme.of(context).textTheme.headline6),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_rounded),
                    onPressed: () => deletetx(transactions[index]),
                    iconSize: 30,
                    color: Colors.red,
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          )
        : LayoutBuilder(
            builder: (ctx, constraints) {
              return Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: constraints.maxHeight*0.1,
                    ),
                    Container(
                      height: constraints.maxHeight*0.6,
                      child: Image.asset(
                        'images/NoTransact.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      'NO TRANSACTION YET!!',
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.red[600]),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
