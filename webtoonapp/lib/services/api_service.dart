import 'dart:convert';

import 'package:http/http.dart';
import 'package:webtoonapp/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getToday() async {
    List<WebtoonModel> webtoons = [];
    // Api GET
    final apidata = await get(Uri.parse("$baseUrl/$today"));
    // GET 성공시
    if (apidata.statusCode == 200) {
      final List<dynamic> json = jsonDecode(apidata.body);
      for (var i in json) {
        webtoons.add(WebtoonModel.fromJson(i));
      }
      return webtoons;
    }
    // GET 실패시 오류 출력
    throw Error();
  }
}
