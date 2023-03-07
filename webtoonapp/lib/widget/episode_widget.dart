import 'package:flutter/material.dart';

class Episode extends StatelessWidget {
  final String id, title, rating, date, thumb;
  const Episode({
    super.key,
    required this.id,
    required this.title,
    required this.rating,
    required this.date,
    required this.thumb,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   child: Image.network(thumb),
        // ),
        Text(title),
        Text(date),
        Text(rating),
      ],
    );
  }
}
