import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function(String, double, DateTime) newTx;

  NewTransaction(this.newTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;
  void add() {
    widget.newTx(titleController.text, double.parse(amountController.text),
        selectedDate!);
    Navigator.pop(context);
  }

  void _selectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null)
        return;
      else
        setState(() {
          selectedDate = value;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                autofocus: true,
                style: Theme.of(context).textTheme.subtitle1,
                decoration: InputDecoration(labelText: "Title"),
                controller: titleController,
              ),
              TextField(
                style: Theme.of(context).textTheme.subtitle1,
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => add(),
              ),
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(selectedDate == null
                        ? 'No Date choosen'
                        : DateFormat.yMMMd().format(selectedDate!)),
                    TextButton(
                      onPressed: _selectDate,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: add,
                child: Text('Add transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
