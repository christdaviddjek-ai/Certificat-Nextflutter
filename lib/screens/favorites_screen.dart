import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../services/favorites_notifier.dart';
import '../widgets/empty_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesNotifier>().favorites;

    return Scaffold(
      appBar: AppBar(title: const Text('Mes favoris')),
      body: favorites.isEmpty
          ? const EmptyState(
              icon: Icons.favorite_border,
              message: 'Aucun favori pour le moment',
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final movie = favorites[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      movie.posterUrl,
                      width: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.movie),
                    ),
                  ),
                  title: Text(movie.title),
                  subtitle: Text('⭐ ${movie.voteAverage.toStringAsFixed(1)}'),
                  onTap: () => context.push('/movie/${movie.id}'),
                );
              },
            ),
    );
  }
}
