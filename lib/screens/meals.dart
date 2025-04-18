import 'package:flutter/material.dart';
import 'package:flutter_meal_app/models/meal.dart';
import 'package:flutter_meal_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});

  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'No meals in this category',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          const SizedBox(height: 16),
          Text(
            'Please try select a different category',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          )
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        // itemBuilder: (ctx, index) => Text(meals[index].title),
        itemBuilder: (ctx, index) => MealItem(meal: meals[index]),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        // using Listview for optimisation where list/text is long
        body: content);
  }
}
