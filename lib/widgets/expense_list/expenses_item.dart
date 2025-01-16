import 'package:flutter/material.dart';
import 'package:expense_app/models/expense.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(expense.title),
    );
  }
}
