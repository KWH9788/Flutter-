import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtoonapp/models/webtoon_detail_model.dart';
import 'package:webtoonapp/models/webtoon_episode_model.dart';
import 'package:webtoonapp/services/api_service.dart';
import 'package:webtoonapp/widget/episode_widget.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late SharedPreferences pref;
  late final Future<WebtoonDetailModel> webtoon =
      ApiService.getDetail(widget.id);
  late final Future<List<WebtoonEpisodeModel>> episodes =
      ApiService.getEpisode(widget.id);

  bool isLiked = false;

  Future prefInit() async {
    pref = await SharedPreferences.getInstance();
    final likedToons = pref.getStringList("likedToons");
    if (likedToons != null) {
      if (likedToons.contains(widget.id) == true) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      await pref.setStringList("likedToons", []);
    }
  }

  @override
  void initState() {
    super.initState();
    prefInit();
  }

  onFavoriteTap() async {
    final likedToons = pref.getStringList('likedToons');
    if (likedToons != null) {
      if (isLiked) {
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }
      await pref.setStringList('likedToons', likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue[300],
        actions: [
          IconButton(
            onPressed: onFavoriteTap,
            icon:
                Icon(isLiked == true ? Icons.favorite : Icons.favorite_outline),
          ),
        ],
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 30,
          ),
          child: Column(
            children: [
              /// Thumb
              ///
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Hero(
                      tag: widget.id,
                      child: Container(
                        width: 250,
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
                        child: Image.network(widget.thumb),
                      ),
                    ),
                  ),
                ],
              ),

              /// Detail
              ///
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Text(
                          "${snapshot.data!.genre} / ${snapshot.data!.age}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
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
              const SizedBox(
                height: 15,
              ),

              /// Episode
              ///
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return makeList(snapshot);
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column makeList(AsyncSnapshot<List<WebtoonEpisodeModel>> snapshot) {
    return Column(
      children: [
        for (var episode in snapshot.data!)
          Episode.init(
            episode: episode,
            webtoonId: widget.id,
          )
      ],
    );
  }
}
