import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../model/transaction.dart';

class ListItem extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransaction;
  final Function updateTransaction;
  final Function datePicker;

  const ListItem({
    super.key,
    required this.deleteTransaction,
    required this.transaction,
    required this.updateTransaction,
    required this.datePicker,
  });

  @override
  Widget build(BuildContext context) {
    DateTime? _selectedDate;
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(transaction.id),
      onDismissed: (direction) {
        deleteTransaction(transaction.id);
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
                  transaction.amount.toStringAsFixed(2),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          title: Text(
            transaction.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            DateFormat.yMMMMd().format(transaction.date),
          ),
          trailing: IconButton(
            onPressed: () {
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
                          updateTransaction(
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
                          decoration:
                              const InputDecoration(labelText: "New Label"),
                        ),
                        TextField(
                          controller: amountController,
                          decoration:
                              const InputDecoration(labelText: 'New Amount'),
                        ),
                        Row(
                          children: [
                            const Text('Choose a date'),
                            IconButton(
                                onPressed: () {
                                  datePicker(_selectedDate);
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
  }
}
