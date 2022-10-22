// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

import './list_item.dart';
import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  final Function updateTransaction;
  final Function datePicker;

  //Constructor....
  const TransactionList({
    super.key,
    required this.transactions,
    required this.datePicker,
    required this.deleteTransaction,
    required this.updateTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraint) {
              return Column(
                children: [
                  Text(
                    'No transaction added so far !',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: constraint.maxHeight * 0.05,
                  ),
                  Container(
                    height: constraint.maxHeight * 0.6,
                    child: Image.asset(
                      'Assets/Images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return ListItem(
                deleteTransaction: deleteTransaction,
                transaction: transactions[index],
                updateTransaction: updateTransaction,
                datePicker: datePicker,
              );
            },
          );
  }
}


//Scroll using ListView (Combination of Column and SingleChildScrollView)

// Widget build(BuildContext context) {
//     return Container(
//       height: 300,
//       child: ListView(
//         children: transactions.map((tx) {
//           return Card(
//             child: Row(
//               children: <Widget>[
//                 Container(
//                   margin: const EdgeInsets.symmetric(
//                     vertical: 10,
//                     horizontal: 15,
//                   ),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.green,
//                       width: 3,
//                     ),
//                   ),
//                   padding: const EdgeInsets.all(10),
//                   child: Text(
//                     'PKR: ${tx.amount.toString()}',
//                     style: const TextStyle(
//                       color: Colors.green,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       tx.title,
//                       style: const TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       DateFormat.yMMMd().format(tx.date),
//                       // ignore: prefer_interpolation_to_compose_strings
//                       //'${tx.date.day.toString()}/${tx.date.month.toString()}/${tx.date.year.toString()}\t',

//                       style: const TextStyle(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }








/// Scrolling using SingleChildScrollView...

// Widget build(BuildContext context) {
//     return Container(
//       height: 300,
//       child: SingleChildScrollView(
//         child: Column(
//           children: transactions.map((tx) {
//             return Card(
//               child: Row(
//                 children: <Widget>[
//                   Container(
//                     margin: const EdgeInsets.symmetric(
//                       vertical: 10,
//                       horizontal: 15,
//                     ),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.green,
//                         width: 3,
//                       ),
//                     ),
//                     padding: const EdgeInsets.all(10),
//                     child: Text(
//                       'PKR: ${tx.amount.toString()}',
//                       style: const TextStyle(
//                         color: Colors.green,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         tx.title,
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         DateFormat.yMMMd().format(tx.date),
//                         // ignore: prefer_interpolation_to_compose_strings
//                         //'${tx.date.day.toString()}/${tx.date.month.toString()}/${tx.date.year.toString()}\t',

//                         style: const TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
