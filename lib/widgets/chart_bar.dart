import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal,
      {super.key});

  @override
  Widget build(BuildContext context) {
    print('spending pt $spendingPctOfTotal');
    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(
            child: Text(
              '\$${spendingAmount.toStringAsFixed(0)}',
              style: TextStyle(color: Colors.indigo),
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.indigo.shade300, width: 1.0),
                  color: Colors.indigo.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label, style: TextStyle(color: Colors.indigo)),
      ],
    );
  }
}
