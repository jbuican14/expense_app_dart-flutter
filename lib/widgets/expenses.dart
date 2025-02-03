import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/expense_list/expenses_list.dart';
import 'package:expense_app/widgets/new_expense.dart';
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

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              onAddExpense: _addExpense,
            ));
  }

  // should be used to whatever part of the app wants to add expense to it
  void _addExpense(Expense expense) {
    setState(() {
      // call on method add() provided by dart
      _registeredExpenses.add(expense);
    });
  }
    
  // remove expenses 
  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expense Tracker"),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense),
          )
        ],
      ),
    );
  }
}
