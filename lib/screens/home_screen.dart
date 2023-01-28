import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';

import '../model/transaction_model.dart';

import '../widgets/transaction_list.dart';
import '../widgets/chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Transaction> _userTransactions = [
    //Transaction(
    //  id: 't1',
    //  title: "New Shoes",
    //  price: 99.99,
    //  date: DateTime.now(),
    //),
    //Transaction(
    //  id: 't2',
    //  title: "New book",
    //  price: 150.26,
    //  date: DateTime.now(),
    //),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double price, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      price: price,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });

    Navigator.of(context).pop();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        //isScrollControlled: true,
        context: ctx,
        builder: (context) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Chart(_recentTransactions),
              TransactionList(_userTransactions, _deleteTransaction),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddNewTransaction(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
