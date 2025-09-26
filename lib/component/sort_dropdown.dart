import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kitchenly/providers/recipe_provider.dart';

class RecipeSortDropdown extends StatefulWidget {
  const RecipeSortDropdown({super.key});

  @override
  State<RecipeSortDropdown> createState() => _RecipeSortDropdownState();
}

class _RecipeSortDropdownState extends State<RecipeSortDropdown> {
  String? _selectedOption;

  final List<String> _options = [
    "A → Z",
    "Z → A",
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedOption,
      hint: const Text("Sort by"),
      items: _options.map((option) {
        return DropdownMenuItem(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedOption = value;
        });

        final provider = context.read<RecipeProvider>();

        switch (value) {
          case "A → Z":
            provider.sortRecipesByName(ascending: true);
            break;
          case "Z → A":
            provider.sortRecipesByName(ascending: false);
            break;
        }
      },
    );
  }
}
