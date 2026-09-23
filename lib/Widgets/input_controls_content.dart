import 'package:flutter/material.dart';
import 'package:prm393_project/theme/app_theme.dart';

class InputControlsContent extends StatefulWidget {
  const InputControlsContent({super.key});

  @override
  State<InputControlsContent> createState() => _InputControlsContentState();
}

class _InputControlsContentState extends State<InputControlsContent> {
  double sliderValue = 50;
  bool switchValue = false;
  String? selectedGenre;
  DateTime? selectedDate;

  String get formattedDate => selectedDate == null
      ? 'None'
      : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';

  Future<void> selectDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      children: [
        // Summary card: shows every updated value in one place
        _SummaryCard(
          rating: sliderValue.round(),
          active: switchValue,
          genre: selectedGenre ?? 'None',
          date: formattedDate,
        ),
        const SizedBox(height: 20),

        // Rating Slider
        _SectionCard(
          icon: Icons.star_rounded,
          title: 'Rating',
          badge: '${sliderValue.round()}',
          child: Column(
            children: [
              Slider(
                value: sliderValue,
                min: 0,
                max: 100,
                divisions: 10,
                label: sliderValue.round().toString(),
                onChanged: (value) {
                  setState(() {
                    sliderValue = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('0', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                    Text('100', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Active Switch
        _SectionCard(
          icon: Icons.visibility_rounded,
          title: 'Status',
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Is movie active?',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      switchValue ? 'Visible to users' : 'Hidden from users',
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              Switch(
                value: switchValue,
                onChanged: (value) {
                  setState(() {
                    switchValue = value;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Genre RadioListTile group
        _SectionCard(
          icon: Icons.local_movies_rounded,
          title: 'Genre',
          badge: selectedGenre,
          child: RadioGroup<String>(
            groupValue: selectedGenre,
            onChanged: (value) {
              setState(() {
                selectedGenre = value;
              });
            },
            child: const Column(
              children: [
                RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Action'),
                  value: 'Action',
                ),
                RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Comedy'),
                  value: 'Comedy',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // DatePicker Button
        _SectionCard(
          icon: Icons.event_rounded,
          title: 'Release date',
          badge: selectedDate == null ? null : formattedDate,
          child: SizedBox(
            width: double.infinity,
            child: FilledButton.tonalIcon(
              onPressed: selectDate,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.calendar_month_rounded),
              label: const Text('Open Date Picker'),
            ),
          ),
        ),
      ],
    );
  }
}

// White card with an icon, a title, an optional value badge and content
class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? badge;
  final Widget child;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.child,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, size: 20, color: colorScheme.primary),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      badge!,
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

// Gradient card summarizing the current input values
class _SummaryCard extends StatelessWidget {
  final int rating;
  final bool active;
  final String genre;
  final String date;

  const _SummaryCard({
    required this.rating,
    required this.active,
    required this.genre,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CURRENT VALUES',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _SummaryItem(label: 'Rating', value: '$rating'),
              _SummaryItem(label: 'Active', value: active ? 'Yes' : 'No'),
              _SummaryItem(label: 'Genre', value: genre),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _SummaryItem(label: 'Release date', value: date),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
