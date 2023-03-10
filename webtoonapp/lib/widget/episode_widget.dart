import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/webtoon_episode_model.dart';

class Episode extends StatelessWidget {
  final String id, title, rating, date, thumb, webtoonId;

  Episode.init({
    super.key,
    required WebtoonEpisodeModel episode,
    required this.webtoonId,
  })  : id = episode.id,
        title = episode.title,
        rating = episode.rating,
        date = episode.date,
        thumb = episode.thumb;

  onButtonTap() async {
    if (id.isEmpty) {
      await launchUrlString(
          "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=1");
    } else {
      await launchUrlString(
          "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${(int.parse(id) + 1)}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
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
      ),
    );
  }
}
