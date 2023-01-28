import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction_model.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction>? transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      child: transactions!.isEmpty
          ? Center(
              child: Text('No Transactions Added Yet...',
                  style:
                      TextStyle(color: Colors.indigo.shade200, fontSize: 25)),
            )
          : ListView.builder(
              itemCount: transactions!.length,
              itemBuilder: ((ctx, index) {
                int revIndex = transactions!.length - 1 - index;
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  key: ValueKey(transactions![revIndex].id),
                  onDismissed: (dir) {
                    if (dir == DismissDirection.endToStart) {
                      deleteTx(transactions![revIndex].id);
                    }
                  },
                  child: Card(
                    //key: ValueKey(transactions![revIndex].id),
                    margin: const EdgeInsets.all(7),
                    elevation: 5,
                    shadowColor: Colors.indigo.shade500,
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 100,
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.indigo, width: 2),
                          ),
                          child: FittedBox(
                            child: Text(
                              '\$ ${transactions![revIndex].price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.indigo,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 180,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: FittedBox(
                                  child: Text(
                                    transactions![revIndex].title,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo.shade900,
                                        letterSpacing: 3),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              DateFormat.yMMMd()
                                  .format(transactions![revIndex].date),
                              style: TextStyle(
                                color: Colors.indigo.shade300,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.indigo.shade300,
                          onPressed: () {
                            deleteTx(transactions![revIndex].id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
    );
  }
}
