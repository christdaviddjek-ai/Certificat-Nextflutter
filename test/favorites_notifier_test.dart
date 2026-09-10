import 'package:flutter_test/flutter_test.dart';

import 'package:cinescope/models/movie.dart';
import 'package:cinescope/services/favorites_notifier.dart';

void main() {
  const movie = Movie(
    id: 1,
    title: 'Film de test',
    overview: '',
    posterPath: '',
    voteAverage: 7.5,
    releaseDate: '2026-01-01',
    genreIds: [],
  );

  test('toggles favorites and notifies listeners', () {
    final notifier = FavoritesNotifier();
    var notifications = 0;
    notifier.addListener(() => notifications++);

    notifier.toggleFavorite(movie);
    expect(notifier.isFavorite(movie.id), isTrue);
    expect(notifier.favorites, contains(movie));
    expect(notifications, 1);

    notifier.toggleFavorite(movie);
    expect(notifier.isFavorite(movie.id), isFalse);
    expect(notifier.favorites, isEmpty);
    expect(notifications, 2);
  });

  test('favorites list cannot be modified externally', () {
    final notifier = FavoritesNotifier();
    notifier.toggleFavorite(movie);

    expect(() => notifier.favorites.add(movie), throwsUnsupportedError);
  });
}
