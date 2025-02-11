// which data structure expenses should have

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMMMd();

const uuid = Uuid();

enum Category { food, travel, leisure, work, home, others }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.train,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.home: Icons.home,
  Category.others: Icons.miscellaneous_services,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList(); // add additional contructure function class

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    // another version of for loop
    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
