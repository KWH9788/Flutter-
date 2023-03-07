import 'package:flutter/material.dart';
import 'package:webtoonapp/models/webtoon_detail_model.dart';
import 'package:webtoonapp/models/webtoon_episode_model.dart';
import 'package:webtoonapp/services/api_service.dart';
import 'package:webtoonapp/widget/episode_widget.dart';

class DetailScreen extends StatelessWidget {
  final String title, thumb, id;
  late final Future<WebtoonDetailModel> webtoon = ApiService.getDetail(id);
  late final Future<List<WebtoonEpisodeModel>> episodes =
      ApiService.getEpisode(id);

  DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue[300],
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        elevation: 1,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Hero(
                  tag: id,
                  child: Container(
                    width: 300,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1.0,
                            offset: const Offset(3, 3),
                            color: Colors.black.withOpacity(0.2),
                          )
                        ]),
                    child: Image.network(thumb),
                  ),
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: webtoon,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var item = snapshot.data;
                return Column(
                  children: [
                    Text(item!.age),
                    Text(item.genre),
                    Text(item.about),
                  ],
                );
              } else if (snapshot.hasError) {
                return const Text("Error!");
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          // FutureBuilder(
          //   future: episodes,
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return Expanded(child: makeList(snapshot));
          //     } else if (snapshot.hasError) {
          //       return const Text("Error!");
          //     } else {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //   },
          // ),
        ],
      ),
    );
  }

  Column makeList(AsyncSnapshot<List<WebtoonEpisodeModel>> snapshot) {
    return Column(
      children: [
        ListView.separated(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            var item = snapshot.data![index];
            return Episode(
              id: item.id,
              title: item.title,
              rating: item.rating,
              date: item.date,
              thumb: item.thumb,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
        )
      ],
    );
  }
}
