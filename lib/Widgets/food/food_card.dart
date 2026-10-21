import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/models/food.dart';
import 'package:food_app/viewmodels/food_viewmodel.dart';

class FoodCard extends ConsumerWidget {
  final Food food;

  const FoodCard({super.key, required this.food});

  Widget _emojiFallback(ColorScheme scheme) {
    return Container(
      alignment: Alignment.center,
      color: scheme.primaryContainer,
      child: Text(food.emoji, style: const TextStyle(fontSize: 44)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: scheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 84,
                height: 84,
                child: food.image == null
                    ? _emojiFallback(scheme)
                    : Image.asset(
                        food.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => _emojiFallback(scheme),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    food.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    food.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: scheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 2),
                      Text(
                        food.rating.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '\$${food.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: scheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: food.isFavorite ? 'Remove favorite' : 'Add favorite',
              icon: Icon(
                food.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: food.isFavorite ? Colors.red : scheme.outline,
              ),
              onPressed: () => ref
                  .read(foodViewModelProvider.notifier)
                  .toggleFavorite(food.id),
            ),
          ],
        ),
      ),
    );
  }
}
