import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final int movieId;
  const DetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Film #$movieId')),
      body: Center(child: Text('Détail du film $movieId')),
    );
  }
}