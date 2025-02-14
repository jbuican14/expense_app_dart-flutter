import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/expense_list/expenses_list.dart';
import 'package:expense_app/widgets/new_expense.dart';
import 'package:expense_app/widgets/chart/chart.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

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
        useSafeArea: true,
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
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    // clear previous snackbar before showing the next one
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 5),
      content: Text('Expense deleted.'),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // find out how much space (width) we have
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = Center(
      child: Text(
        'Welcome to your new expense tracker! \nLet\'s get started by adding your first expense.',
        style: TextStyle(
          fontSize: 18,
          foreground: Paint()
            ..shader = ui.Gradient.linear(
                const Offset(0, 20), const Offset(250, 20), <Color>[
              Colors.pinkAccent,
              const Color.fromARGB(255, 19, 19, 2)
            ]),
        ),
      ),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: _registeredExpenses, onRemoveExpense: _removeExpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expense Tracker"),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add))
        ],
      ),
      body: width < 600
          ? Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent),
        ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
