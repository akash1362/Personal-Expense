import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Chart_bar.dart';
import '../models/Transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recent;
  Chart(this.recent);

  List<Map<String, Object>> get createRecent {
    return List.generate(7, (index) {
      var weekday = DateTime.now().subtract((Duration(days: index)));
      double sum = 0.0;
      for (Transaction tx in recent) {
        if (tx.date.day == weekday.day &&
            tx.date.month == weekday.month &&
            tx.date.year == weekday.year) sum += tx.amount;
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amt': sum
      };
    }).reversed.toList();
  }

  double get totalSpend {
    return createRecent.fold(0.0, (sum, item) => sum + (item['amt'] as double));
  }

  @override
  Widget build(BuildContext context) {
    //print(createRecent);
    return Card(
      color: Colors.black12,
      elevation: 5,
      margin: EdgeInsets.all(5),
      child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  createRecent.map((temp) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  temp['day'].toString(),
                  temp['amt'] as double,
                  totalSpend == 0.0 ? 0.0 : (temp['amt'] as double) / totalSpend,
                ),
              );
            }).toList(),
          ),
        ),
    );
  }
}
