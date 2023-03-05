import 'package:flutter/material.dart';
import 'package:webtoonapp/models/webtoon_model.dart';
import 'package:webtoonapp/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final Future<List<WebtoonModel>> webtoons = ApiService.getToday();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue[300],
        title: const Text(
          "Today's WebToon",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        elevation: 1,
      ),
      body: FutureBuilder(
        future: webtoons,
        // snapshot: future의 상태를 담고있는 매개변수
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return makeList(snapshot);
          } else if (snapshot.hasError) {
            return const Text("Error!");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var item = snapshot.data![index];
        return Column(
          children: [
            Image.network(item.thumb),
            Text(item.title),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 50,
      ),
    );
  }
}
