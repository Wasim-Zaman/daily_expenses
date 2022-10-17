import 'package:daily_expenses/widgets/chart_bars.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> lastWeekTransactions;
  const Chart({super.key, required this.lastWeekTransactions});

  List<Map<String, Object>> get groupOfTransactionAmount {
    return List.generate(7, (index) {
      //last seven days...
      final weekDays = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.0;
      // calculate the total amount of each separate day of the week.
      // for that we need to check each transaction belongs to which day...
      for (var tx in lastWeekTransactions) {
        if (weekDays.day == tx.date.day &&
            weekDays.month == tx.date.month &&
            weekDays.year == tx.date.year) {
          totalAmount += tx.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDays).substring(0, 1),
        'amount': totalAmount,
      };
    }).reversed.toList();
  }

  double get sumOfAllSpendings {
    return groupOfTransactionAmount.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupOfTransactionAmount.map((tx) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBars(
                amountValue: tx['amount'] as double,
                label: tx['day'].toString(),
                totalAmountPercentage: sumOfAllSpendings == 0.0
                    ? 0.0
                    : (tx['amount'] as double) / sumOfAllSpendings,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
