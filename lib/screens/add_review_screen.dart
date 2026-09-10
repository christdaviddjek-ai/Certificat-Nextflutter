import 'package:flutter/material.dart';

class AddReviewScreen extends StatelessWidget {
  final int movieId;
  const AddReviewScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un avis')),
      body: Center(child: Text('Formulaire pour le film $movieId')),
    );
  }
}