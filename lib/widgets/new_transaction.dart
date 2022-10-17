import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  const NewTransaction({super.key, required this.addTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // String? labelInput;
  final labelController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void addData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final labelText = labelController.text;
    final amountText = double.parse(amountController.text);

    if (labelText.isEmpty || amountText.isNegative || _selectedDate == null) {
      return;
    }
    widget.addTransaction(
      labelText,
      amountText,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

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
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).selectedRowColor,
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            //text fields
            TextField(
              // onChanged: (value) {
              //   labelInput = value;
              // },
              controller: labelController,
              decoration: const InputDecoration(
                labelText: 'Label',
              ),
              // onSubmitted: (_) => add_data(),
            ),

            TextField(
              // onChanged: ((value) {
              //   amountInput = double.parse(value);
              // }),
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              onSubmitted: (_) => addData(),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 80,
              child: Row(
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No date chosen 😥'
                        : 'Selected Date: ${DateFormat.yMd().format(_selectedDate!)}',
                  ),
                  TextButton(
                    onPressed: () {
                      _currentDatePicker();
                    },
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: (
                  // if (labelInput != null && amountInput != null) {
                  //   add_transaction(labelInput, amountInput);
                  // }

                  // else {
                  //   showDialog(
                  //     context: context,
                  //     builder: (context) => AlertDialog(
                  //       title: Text("Kindly fill all the required text fields"),
                  //       icon: Icon(Icons.error),
                  //       actions: [
                  //         TextButton(
                  //           child: Text("Done"),
                  //           onPressed: () => {Navigator.of(context).pop()},
                  //         )
                  //       ],
                  //     ),
                  //   );
                  // }

                  addData),
              // style: ButtonStyle(
              //   foregroundColor: MaterialStateProperty.all(
              //     Theme.of(context).primaryColorDark,
              //   ),
              // ),

              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).textTheme.button?.color,
              ),

              child: const Text('Add Transaction'),
            ),
          ]),
        ),
      ),
    );
  }
}
