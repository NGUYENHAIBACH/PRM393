import 'package:flutter/material.dart';
import 'package:prm393_project/Widgets/app_structure_content.dart';
import 'package:prm393_project/theme/app_theme.dart';

class AppStructureDemo extends StatefulWidget {
  const AppStructureDemo({super.key});

  @override
  State<AppStructureDemo> createState() => _AppStructureDemoState();
}

class _AppStructureDemoState extends State<AppStructureDemo> {
  // Movies added to the watchlist with the FloatingActionButton
  final List<String> watchlist = [];

  static const List<String> suggestions = [
    'Dune: Part Two',
    'Oppenheimer',
    'The Batman',
    'Spider-Verse',
    'Top Gun: Maverick',
    'Everything Everywhere',
  ];

  void addMovie() {
    final title = suggestions[watchlist.length % suggestions.length];
    setState(() {
      watchlist.add(title);
    });
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Added "$title" to watchlist'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void removeMovie(int index) {
    setState(() {
      watchlist.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Scaffold = AppBar + Body + FloatingActionButton
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Structure'),
        actions: [
          // Dark Mode toggle: changes MaterialApp.themeMode
          Icon(
            isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
            size: 20,
          ),
          const SizedBox(width: 4),
          Switch(
            value: isDark,
            onChanged: AppTheme.toggleDarkMode,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: AppStructureContent(
        isDark: isDark,
        watchlist: watchlist,
        onRemove: removeMovie,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addMovie,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add movie'),
      ),
    );
  }
}
