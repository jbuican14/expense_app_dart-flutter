import 'package:expense_app/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 69, 144, 229),
  brightness: Brightness.light,
  contrastLevel: 0.2,
);

void main() {
  runApp(
    MaterialApp(
        // add this line of material 2 is on
        theme: ThemeData().copyWith(
            // scaffoldBackgroundColor: kColorScheme,
            colorScheme: kColorScheme,
            cardTheme: CardTheme().copyWith(
                color: kColorScheme.secondaryContainer,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
            appBarTheme: AppBarTheme().copyWith(
                backgroundColor: kColorScheme.onPrimaryContainer,
                foregroundColor: kColorScheme.primaryContainer),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kColorScheme.primaryContainer),
            ),
            textTheme: ThemeData().textTheme.copyWith(
                  titleLarge: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kColorScheme.onSecondaryContainer,
                      fontSize: 18),
                )),
        home: Expenses()),
  );
}
