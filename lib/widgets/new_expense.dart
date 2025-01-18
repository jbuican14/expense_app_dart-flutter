import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewExpensesState();
  }
}

class _NewExpensesState extends State<NewExpense> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            maxLength: 55,
            decoration: InputDecoration(label: Text('Title')),
          )
        ],
      ),
    );
  }
}
