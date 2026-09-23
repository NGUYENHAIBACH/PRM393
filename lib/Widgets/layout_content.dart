import 'package:flutter/material.dart';

// Simple data holder for one movie in the list
class _Movie {
  final String title;
  final String genre;
  final int year;
  final double rating;
  final List<Color> colors;

  const _Movie(this.title, this.genre, this.year, this.rating, this.colors);
}

class LayoutContent extends StatelessWidget {
  const LayoutContent({super.key});

  // Sample data for the ListView
  static const List<_Movie> _movies = [
    _Movie('Avatar', 'Sci-Fi', 2009, 7.9, [Color(0xFF1FA2FF), Color(0xFF12D8FA)]),
    _Movie('Inception', 'Thriller', 2010, 8.8, [Color(0xFF6A5AE0), Color(0xFF9C6BF5)]),
    _Movie('Interstellar', 'Adventure', 2014, 8.7, [Color(0xFFFF8A00), Color(0xFFE52E71)]),
    _Movie('Joker', 'Drama', 2019, 8.4, [Color(0xFF11998E), Color(0xFF38EF7D)]),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Padding keeps consistent 16px spacing around the whole screen
    return Padding(
      padding: const EdgeInsets.all(16.0),
      // Column splits the screen into vertical sections
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Row: section title on the left, action on the right
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Now Playing',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Popular movies this week',
                      style: textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              TextButton(onPressed: () {}, child: const Text('See all')),
            ],
          ),
          const SizedBox(height: 16),

          // Expanded gives the ListView a bounded height inside the Column
          Expanded(
            // ListView.builder only builds the items that are visible
            child: ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _MovieCard(movie: _movies[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final _Movie movie;

  const _MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Poster placeholder: gradient box with the first letter
            Container(
              width: 64,
              height: 88,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: movie.colors,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                movie.title[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${movie.genre} · ${movie.year}',
                    style: textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 18,
                        color: Color(0xFFFFB020),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        movie.rating.toString(),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.bookmark_border_rounded),
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
