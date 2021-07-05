import 'package:flutter/material.dart';
import 'package:personal_expense/widgets/Chart.dart';
import 'package:personal_expense/models/Transaction.dart';
import 'package:personal_expense/widgets/new_transaction.dart';
import 'package:personal_expense/widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.deepPurpleAccent,
        fontFamily: 'Quicksand-Medium',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  
  var showchart = false;
  List<Transaction> get recentT {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addnewTransaction(String topic, double amt, DateTime ofthis) {
    Transaction tx = Transaction(
      id: DateTime.now().toString(),
      title: topic,
      amount: amt,
      date: ofthis,
    );
    setState(() {
      _transactions.add(tx);
    });
    //print(recentT);
  }

  void _startT(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bctx) {
        return GestureDetector(
          child: NewTransaction(_addnewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deletetransact(Transaction tx) {
    setState(() {
      _transactions.remove(tx);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
      MediaQuery.of(context).orientation == Orientation.landscape;
    final PreferredSizeWidget apbar = AppBar(
      title: Text('Personal Expense'),
      actions: [
        IconButton(
          onPressed: () => _startT(context),
          icon: Icon(Icons.add),
        ),
      ],
    );
    final chrtWidget=Container(
                    height: (MediaQuery.of(context).size.height -
                            apbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        (isLandscape?0.7:0.3),
                    child: Chart(recentT),
                  );
    return  SafeArea(
      child: Scaffold(
        appBar: apbar,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if(isLandscape) Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text('Show Chart  '),
                  ),
                  Switch(
                      value: showchart,
                      onChanged: (val) {
                        setState(() {
                          showchart = val;
                        });
                      }),
                ],
              ),
              if(!isLandscape)    chrtWidget,  
              (showchart && isLandscape)
                  ? chrtWidget
                  : Container(
                      height: (MediaQuery.of(context).size.height -
                              apbar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: TransactionList(
                        transactions: _transactions,
                        deletetx: _deletetransact,
                      ),
                    ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _startT(context),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
