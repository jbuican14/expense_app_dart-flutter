import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense_app/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpensesState();
  }
}

class _NewExpensesState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 10, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                  title: Text('Invalid input'),
                  content: Text(
                      'Please make sure a valid title, date and category were entered.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Text('Okay'),
                    )
                  ]));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid input'),
          content: Text(
              'Please make sure a valid title, date and category were entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Okay'),
            )
          ],
        ),
      );
    }
  }

// validate for form
  void _submitExpensesData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null;

    _selectedDate ??= DateTime.now(); // check null value

    if (_titleController.text.trim().isEmpty || amountIsInvalid) {
      _showDialog();
      return;
    }

    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    ); //you can get access to it
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // adjust your media query
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      final txtInputTitle = TextField(
        controller: _titleController,
        maxLength: 55,
        decoration: InputDecoration(label: Text('Title')),
      );

      final txtInputAmount = TextField(
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: _amountController,
        maxLength: 20,
        decoration: InputDecoration(label: Text('Amount'), prefixText: '£ '),
      );

      final dropdownBtn = DropdownButton(
          value: _selectedCategory,
          items: Category.values
              .map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(category.name.toUpperCase()),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value == null) {
              return;
            }
            setState(() {
              _selectedCategory = value;
            });
          });

      final datePicker = Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_selectedDate == null
                ? formatter.format(DateTime.now())
                : formatter.format(_selectedDate!)),
            IconButton(
                onPressed: _presentDatePicker,
                icon: const Icon(Icons.calendar_month))
          ],
        ),
      );

      final cancelBtn = TextButton(
        onPressed: () {
          // use buildin class 'Navigator'to remove overlay on the screen
          Navigator.pop(context);
        },
        child: Text('Cancel'),
      );

      final saveBtn = ElevatedButton(
        onPressed: _submitExpensesData,
        child: Text('Save Expense'),
      );

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    // not sure if adding this would matter
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: txtInputTitle,
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: txtInputAmount,
                      ),
                    ],
                  )
                else
                  txtInputTitle,
                if (width >= 600)
                  Row(
                    children: [
                      dropdownBtn,
                      const SizedBox(
                        width: 24,
                      ),
                      datePicker
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: txtInputAmount,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      datePicker,
                    ],
                  ),
                SizedBox(
                  height: 16,
                ),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      cancelBtn,
                      saveBtn,
                    ],
                  )
                else
                  Row(
                    children: [
                      dropdownBtn,
                      Spacer(),
                      cancelBtn,
                      saveBtn,
                      SizedBox(
                        width: 20,
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
