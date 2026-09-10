import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cinescope/screens/add_review_screen.dart';
import 'package:cinescope/widgets/movie_card.dart';
import 'package:cinescope/models/movie.dart';

void main() {
  testWidgets('AddReviewScreen validates required fields', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: AddReviewScreen(movieId: 1)),
    );

    await tester.tap(find.text("Envoyer l'avis"));
    await tester.pump();

    expect(find.text('Le nom est obligatoire'), findsOneWidget);
    expect(find.text('Le commentaire est obligatoire'), findsOneWidget);
    expect(find.byType(Slider), findsOneWidget);
  });

  testWidgets('MovieCard displays movie title and rating', (
    WidgetTester tester,
  ) async {
    var tapped = false;
    const movie = Movie(
      id: 1,
      title: 'Film de test',
      overview: 'Synopsis',
      posterPath: '',
      voteAverage: 8.4,
      releaseDate: '2026-01-01',
      genreIds: [],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 400,
            width: 200,
            child: MovieCard(movie: movie, onTap: () => tapped = true),
          ),
        ),
      ),
    );

    expect(find.text('Film de test'), findsOneWidget);
    expect(find.text('8.4'), findsOneWidget);

    await tester.tap(find.text('Film de test'));
    expect(tapped, isTrue);
  });
}
