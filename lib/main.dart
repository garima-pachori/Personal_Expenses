import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
   @override
   _MyHomePageState createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage>{
    final List<Transaction> userTransaction=[
    Transaction(
      id: 't1', 
      title: 'New Shoes', 
      amount: 69.99, 
      date: DateTime.now(),
      ),
    Transaction(
      id:'t2', 
      title: 'Weekly groceries', 
      amount: 16.53, 
      date: DateTime.now(),
    ),

  ];

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


  void _StartAddNewTransaction(BuildContext,ctx){
    showModalBottomSheet(context: ctx,builder: (_) {
        return NewTransaction(addNewTransaction);
    },);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _StartAddNewTransaction,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[          
            Container(
              width: double.infinity,
              child: Card(
                  color: Colors.blue,
                  child: Text('CHART!'),
                  elevation: 5,
              ),
            ),
           TransactionList(userTransaction),
        ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _StartAddNewTransaction
      ),
    );
  }
}
}
