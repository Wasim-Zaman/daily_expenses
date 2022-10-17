// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './model/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData(
      MaterialColor primaryColor,
      MaterialColor accentColor,
    ) {
      return ThemeData(
        primarySwatch: primaryColor,
        accentColor: accentColor,
        fontFamily: 'Quicksand',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        textTheme: const TextTheme(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            // color: Theme.of(context).primaryColorLight,
          ),
          button: TextStyle(
            color: Colors.white,
            // fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Application',
      home: const MyHome(),
      darkTheme: themeData(Colors.blueGrey, Colors.deepPurple),
      theme: themeData(Colors.purple, Colors.yellow),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final List<Transaction> _transactions = [
    Transaction(
      id: DateTime.now().toString(),
      title: 'Pizza 🍕',
      amount: 2500,
      date: DateTime.now(),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'Eggs 🥚',
      amount: 500,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'Tomatos 🍅',
      amount: 200,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'Apples 🍎',
      amount: 300,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'Grapes 🍇',
      amount: 120,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'Vegs 🥦🌶',
      amount: 800,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'Green-Apples 🍏',
      amount: 200,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'Vegs 🥦🌶',
      amount: 800,
      date: DateTime.now(),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'Green-Apples 🍏',
      amount: 200,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
  ];

  bool _showBar = false;

  // This getter actually returns the List of transactions but those within the
  // last week
  List<Transaction> get _lastWeekTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(const Duration(days: 7)),
      );
    }).toList();
  }

  // Unique ID
  void _addNewTransaction(String title, double amount, DateTime datePicked) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(), //id.toString(),
      title: title,
      amount: amount,
      date: datePicked,
    );
    // id += 1;

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _startAddingTransactions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransaction(addTransaction: _addNewTransaction);
      },
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
    );
  }

  void deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void updateTransaction(
      int index, String title, double amount, DateTime date) {
    setState(() {
      _transactions[index].title = title;
      _transactions[index].amount = amount;
      _transactions[index].date = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    // in order to manage portrait and landscape mode, we define a variable
    // in order to check if we are in landscape mode or not,
    // so that we can make separate display for both modes

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    /*Assigning the app bar into the variable so that we can subtract its size
      from the total size of the screen
    */
    var appBar = AppBar(
      title: const Text('Daily Expenses'),
      backgroundColor: Theme.of(context).primaryColor,
      actions: [
        IconButton(
          onPressed: () => _startAddingTransactions(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );

    final txList = SizedBox(
      height: (MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              appBar.preferredSize.height) *
          0.7,
      child: TransactionList(
        transactions: _transactions,
        deleteTx: deleteTransaction,
        updateTx: updateTransaction,
      ),
    );

    Widget showBars(double multiplicationFactor) {
      return SizedBox(
        // height: (MediaQuery.of(context).size.height -
        //         MediaQuery.of(context).padding.top -
        //         appBar.preferredSize.height) *
        //     0.3,
        height: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                appBar.preferredSize.height) *
            multiplicationFactor,

        child: Chart(lastWeekTransactions: _lastWeekTransactions),
      );
    }

    return Scaffold(
      appBar: appBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddingTransactions(context),
        child: const Icon(Icons.add),
        // backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Show Bars'),
                  Switch.adaptive(
                    value: _showBar,
                    onChanged: (value) {
                      setState(() {
                        _showBar = value;
                      });
                    },
                  )
                ],
              ),
            if (!isLandscape) showBars(0.3),
            if (!isLandscape) txList,
            if (isLandscape) _showBar ? showBars(0.8) : txList,
          ],
        ),
      ),
    );
  }
}
