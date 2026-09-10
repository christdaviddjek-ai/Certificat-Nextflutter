import 'package:flutter/material.dart';

import '../models/movie.dart';

class FavoritesNotifier extends ChangeNotifier {
  final List<Movie> _favorites = [];

  List<Movie> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(int movieId) {
    return _favorites.any((movie) => movie.id == movieId);
  }

  void toggleFavorite(Movie movie) {
    if (isFavorite(movie.id)) {
      _favorites.removeWhere((favorite) => favorite.id == movie.id);
    } else {
      _favorites.add(movie);
    }
    notifyListeners();
  }
}
