import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function add_tx;
  NewTransactions(this.add_tx);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final TextEditingController _titleTextF = TextEditingController();

  final TextEditingController _priceTextF = TextEditingController();
  var _selectedDate;
  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _submitData() {
    final title = _titleTextF.text;
    final amt = double.parse(_priceTextF.text);
    if (title.isEmpty || amt <= 0 || _selectedDate == null) {
      return;
    }
    widget.add_tx(
        _titleTextF.text, double.parse(_priceTextF.text), _selectedDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // final keybardfactor = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 30,
        ),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleTextF,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Price'),
              controller: _priceTextF,
              onSubmitted: (_) => _submitData(),
              keyboardType: TextInputType.number,
            ),
            Container(
              height: 100,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date:${DateFormat.yMMMEd().format(_selectedDate)}'),
                  ),
                  FlatButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      _presentDatePicker();
                    },
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: () {
                _submitData();
              },
            ),
          ],
        ),
      ),
    );
  }
}
