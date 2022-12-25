import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        // appBarTheme: AppBarTheme(
        //   textTheme: ThemeData.light().textTheme.copyWith(
        //     title: TextStyle(
        //       fontFamily: 'OpenSans',
        //       fontSize: 20,
        //       fontWeight: FontWeight.bold,
        //       ),
        //   ),
        // ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
   @override
   _MyHomePageState createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage>{
    
  final List<Transaction> userTransaction=
  [
    // Transaction(
    //   id: 't1', 
    //   title: 'New Shoes', 
    //   amount: 69.99, 
    //   date: DateTime.now(),
    //   ),
    // Transaction(
    //   id:'t2', 
    //   title: 'Weekly groceries', 
    //   amount: 16.53, 
    //   date: DateTime.now(),
    // ),

  ];

  List<Transaction> get recentTransaction{
     return userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ),);
     }).toList();
  }

  void addNewTransaction(String txTitle, double txAmount){
      final newTx=Transaction(
          title: txTitle,
          amount: txAmount, 
          date: DateTime.now(),
          id: DateTime.now().toString(),
      );

      setState((){
        userTransaction.add(newTx);
      }
      );

  }


  void _StartAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses', style: TextStyle(fontFamily: 'OpenSans'),),
        actions: <Widget>[ 
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _StartAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[          
           Chart(recentTransaction),
           TransactionList(userTransaction),
        ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _StartAddNewTransaction(context)
      ),
    );
  }
}

