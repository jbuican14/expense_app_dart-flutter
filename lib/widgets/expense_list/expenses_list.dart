import 'package:flutter/material.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/expense_list/expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        onDismissed: (direction) => {onRemoveExpense(expenses[index])},
        child: ExpensesItem(expenses[index]),
      ),
    );
  }
}
