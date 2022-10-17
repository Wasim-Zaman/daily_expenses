// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  final Function updateTx;

  //Constructor....
  const TransactionList({
    super.key,
    required this.transactions,
    required this.deleteTx,
    required this.updateTx,
  });

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  DateTime? _selectedDate;
  void _currentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2014),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
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
    return widget.transactions.isEmpty
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
            itemCount: widget.transactions.length,
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.endToStart,
                key: Key(widget.transactions[index].id),
                onDismissed: (direction) {
                  widget.deleteTx(widget.transactions[index].id);
                },
                child: Card(
                  elevation: 7,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: FittedBox(
                          child: Text(
                            widget.transactions[index].amount
                                .toStringAsFixed(2),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      widget.transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd()
                          .format(widget.transactions[index].date),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        int i = widget.transactions.indexWhere((element) {
                          return element.id == widget.transactions[index].id;
                        });

                        final labelController = TextEditingController();
                        final amountController = TextEditingController();

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    if (labelController.text.isEmpty ||
                                        amountController.text.isEmpty ||
                                        _selectedDate == null) {
                                      return;
                                    }
                                    widget.updateTx(
                                      i,
                                      labelController.text,
                                      double.parse(amountController.text),
                                      _selectedDate,
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Update'),
                                )
                              ],
                              title: Column(
                                children: [
                                  TextField(
                                    controller: labelController,
                                    decoration: const InputDecoration(
                                        labelText: "New Label"),
                                  ),
                                  TextField(
                                    controller: amountController,
                                    decoration: const InputDecoration(
                                        labelText: 'New Amount'),
                                  ),
                                  Row(
                                    children: [
                                      const Text('Choose a date'),
                                      IconButton(
                                          onPressed: () {
                                            _currentDatePicker();
                                          },
                                          icon: const Icon(Icons.date_range)),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                      ),
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                ),
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
