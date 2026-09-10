import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/movie.dart';

class MovieApiService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static String get _apiKey => dotenv.env['TMDB_API_KEY'] ?? '';

  // Films populaires (pour l'écran d'accueil)
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    final uri = Uri.parse(
      '$_baseUrl/movie/popular?api_key=$_apiKey&language=fr-FR&page=$page',
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;
      return results
          .map((json) => Movie.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Erreur API : ${response.statusCode}');
    }
  }

  // Recherche de films par mot-clé
  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    if (query.isEmpty) return [];

    final uri = Uri.parse(
      '$_baseUrl/search/movie?api_key=$_apiKey&language=fr-FR&query=${Uri.encodeComponent(query)}&page=$page',
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;
      return results
          .map((json) => Movie.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Erreur API : ${response.statusCode}');
    }
  }

  // Détail d'un film précis (pour DetailScreen)
  Future<Movie> getMovieDetail(int movieId) async {
    final uri = Uri.parse(
      '$_baseUrl/movie/$movieId?api_key=$_apiKey&language=fr-FR',
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return Movie.fromJson(json);
    } else {
      throw Exception('Erreur API : ${response.statusCode}');
    }
  }
}