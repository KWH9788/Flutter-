import 'package:flutter/material.dart';

import '../models/webtoon_episode_model.dart';

class Episode extends StatelessWidget {
  final String id, title, rating, date, thumb;

  Episode.init({super.key, required WebtoonEpisodeModel episode})
      : id = episode.id,
        title = episode.title,
        rating = episode.rating,
        date = episode.date,
        thumb = episode.thumb;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Thumb
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            width: 100,
            child: Image.network(thumb),
          ),
          // Context
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(title),
                Text("$date  ★: $rating"),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_sharp),
        ],
      ),
    );
  }
}
