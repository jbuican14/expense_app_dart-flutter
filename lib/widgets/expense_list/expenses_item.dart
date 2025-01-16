import 'package:flutter/material.dart';
import 'package:expense_app/models/expense.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('£${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(Icons.alarm),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(expense.date.toString())
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
