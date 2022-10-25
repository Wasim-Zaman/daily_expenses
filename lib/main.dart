import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:qr_flutter/qr_flutter.dart';

// import 'package:flutter/services.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './model/transaction.dart';
import './model/theme_data.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Application',
      home: const MyHome(),
      darkTheme: themeData(Colors.blueGrey, Colors.deepPurple),
      theme: themeData(Colors.purple, Colors.lightBlue),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  // List of item bought
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

  /*
  This getter actually returns the List of transactions but those within the
  last week
  */

  List<Transaction> get _lastWeekTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(const Duration(days: 7)),
      );
    }).toList();
  }

  // To add new transaction into the list of transactions
  void _addNewTransaction(String title, double amount, DateTime datePicked) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(), //id.toString(),
      title: title,
      amount: amount,
      date: datePicked,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  // When clicking the add button using floating action button or app bar button
  void _startAddingTransactions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return NewTransaction(addTransaction: _addNewTransaction);
      },
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
    );
  }

  // Dismissing the listed transaction into the screen
  void deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  // Clicking the update transaction button at the end of the card (transactin)
  void updateTransaction(
    Transaction transaction,
    String title,
    double amount,
    DateTime date,
  ) {
    int i = _transactions.indexWhere((element) {
      return element.id == transaction.id;
    });
    setState(() {
      transaction.title = title;
      transaction.amount = amount;
      transaction.date = date;
    });
  }

  // Choosing a date for a specific transaction
  void _currentDatePicker(DateTime selectedDate) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2014),
    ).then((value) {
      if (value == null) {
        return;
      }
      selectedDate = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    /*
     in order to manage portrait and landscape mode, we define a variable
     in order to check if we are in landscape mode or not,
     so that we can make separate display for both modes
    */
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final MediaQueryData mediaQuery = MediaQuery.of(context);

    /*Assigning the app bar into the variable so that we can subtract its size
      from the total size of the screen
    */
    var appBar = AppBar(
      title: const Text('Daily Expenses'),
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      shadowColor: Colors.black,
      actions: [
        IconButton(
          onPressed: () => _startAddingTransactions(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );

    final txList = SizedBox(
      height: (mediaQuery.size.height -
              mediaQuery.padding.top -
              appBar.preferredSize.height) *
          0.7,
      child: TransactionList(
        transactions: _transactions,
        deleteTransaction: deleteTransaction,
        updateTransaction: updateTransaction,
        datePicker: _currentDatePicker,
      ),
    );

    // Different sized chart for protrait and landscape mode

    Widget showChart(double multiplicationFactor) {
      return SizedBox(
        // height: (MediaQuery.of(context).size.height -
        //         MediaQuery.of(context).padding.top -
        //         appBar.preferredSize.height) *
        //     0.3,
        height: (mediaQuery.size.height -
                mediaQuery.padding.top -
                appBar.preferredSize.height) *
            multiplicationFactor,

        child: Chart(lastWeekTransactions: _lastWeekTransactions),
      );
    }

    List<Widget> _buildLandscapeTree() {
      return [
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
        _showBar ? showChart(0.8) : txList
      ];
    }

    List<Widget> _buildPortraitTree() {
      return [
        showChart(0.3),
        txList,
      ];
    }

    // create some values
    Color pickerColor = Color(0xff443a49);
    Color currentColor = Color(0xff443a49);

// ValueChanged<Color> callback
    void changeColor(Color color) {
      setState(() => pickerColor = color);
    }

    return Scaffold(
      appBar: appBar,
      drawer: Drawer(
        // backgroundColor: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('Assets/Images/myPic.png'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    trailing: FittedBox(
                      child: Column(
                        children: <Widget>[
                          QrImage(
                            data:
                                'https://github.com/Wasim-Zaman/daily_expenses',
                            version: QrVersions.auto,
                            size: 80,
                            gapless: false,
                          ),
                          const Text(
                            "Scan Me",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  const ListTile(
                    title: Text(
                      "Wasim Zaman",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    subtitle: Text("wasimxaman13@gmail.com"),
                  )
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: const Text('Select Theme'),
              onTap: () {},
              selected: true,
            ),
          ],
        ),
      ),
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
            // If the device is in landscape mode...
            if (isLandscape) ..._buildLandscapeTree(),

            // If the device is in portrait mode....
            if (!isLandscape) ..._buildPortraitTree(),
          ],
        ),
      ),
    );
  }
}
