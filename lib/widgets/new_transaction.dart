import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_priceController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredPrice = double.parse(_priceController.text);

    if (enteredTitle.isEmpty || enteredPrice <= 0) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredPrice,
      _selectedDate,
    );
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
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
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    color: Colors.indigo.shade300,
                  ),
                ),
                controller: _titleController,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(
                    color: Colors.indigo.shade300,
                  ),
                ),
                controller: _priceController,
                keyboardType: TextInputType.number,
                //onSubmitted: submitData,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No Date Chosen!'
                        : DateFormat.yMd().format(_selectedDate!).toString(),
                    style: const TextStyle(
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                      onPressed: _presentDatePicker,
                      child: const Text(
                        'Choose Date',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.indigo),
                      )),
                ],
              ),
              TextButton(
                onPressed: () {
                  _submitData();
                },
                style: TextButton.styleFrom(
                  side: const BorderSide(
                    width: 1.0,
                    color: Colors.indigo,
                  ),
                ),
                child: const Text(
                  'Add Transaction',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
