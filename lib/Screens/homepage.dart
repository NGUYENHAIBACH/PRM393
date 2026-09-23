import 'package:flutter/material.dart';
import 'package:prm393_project/Screens/app_structure_demo.dart';
import 'package:prm393_project/Screens/core_widgets_demo.dart';
import 'package:prm393_project/Screens/input_controls_demo.dart';
import 'package:prm393_project/Screens/layout_demo.dart';
import 'package:prm393_project/theme/app_theme.dart';

// Data for one exercise entry on the Homepage
class _Exercise {
  final String title;
  final String subtitle;
  final IconData icon;
  final WidgetBuilder builder;

  const _Exercise(this.title, this.subtitle, this.icon, this.builder);
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  static final List<_Exercise> _exercises = [
    _Exercise(
      'Core Widgets',
      'Text, Image, Icon, Card, ListTile',
      Icons.widgets_rounded,
      (context) => const CoreWidgetsDemo(),
    ),
    _Exercise(
      'Input Controls',
      'Slider, Switch, Radio, DatePicker',
      Icons.tune_rounded,
      (context) => const InputControlsDemo(),
    ),
    _Exercise(
      'Layout Basics',
      'Column, Row, Padding, ListView',
      Icons.dashboard_rounded,
      (context) => const LayoutDemo(),
    ),
    _Exercise(
      'App Structure & Theme',
      'Scaffold, AppBar, FAB, Dark mode',
      Icons.palette_rounded,
      (context) => const AppStructureDemo(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Gradient header card
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 12, 24),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.seed.withValues(alpha: 0.3),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.menu_rounded, color: Colors.white),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'LAB 4 · PRM393',
                    style: textTheme.labelMedium?.copyWith(
                      color: Colors.white70,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Flutter UI\nFundamentals',
                    style: textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_exercises.length} exercises',
                    style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            Text(
              'Exercises',
              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),

            // One card per exercise, tap to open the screen
            for (var i = 0; i < _exercises.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _ExerciseCard(number: i + 1, exercise: _exercises[i]),
              ),
          ],
        ),
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  final int number;
  final _Exercise exercise;

  const _ExerciseCard({required this.number, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: exercise.builder),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Gradient icon tile
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(exercise.icon, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EXERCISE $number',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      exercise.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      exercise.subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: Theme.of(context).colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
