import 'package:flutter/material.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/expense_list/expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => ExpensesItem(expenses[index]),
    );
  }
}
