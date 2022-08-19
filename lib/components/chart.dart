import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
    required this.recentTransactions,
  }) : super(key: key);

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get _groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSom = 0.00;

      for (var transaction in recentTransactions) {
        bool sameDay = transaction.date.day == weekDay.day;
        bool sameMonth = transaction.date.month == weekDay.month;
        bool sameYear = transaction.date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSom += transaction.value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0].toUpperCase(),
        'value': totalSom,
      };
    }).reversed.toList();
  }

  double get _weekValue{
    return _groupedTransactions.fold(0, (som, transaction) {
      return som + (transaction['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'].toString(),
                value: (tr['value'] as double),
                percentage: _weekValue == 0 ? 0 : (tr['value'] as double) / _weekValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
