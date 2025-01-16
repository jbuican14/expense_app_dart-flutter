import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/expense_list/expenses_list.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  // add dummy
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Food',
        amount: 50,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Movie tickets',
        amount: 30,
        date: DateTime.now(),
        category: Category.leisure),
  ];
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses),
          )
        ],
      ),
    );
  }
}
