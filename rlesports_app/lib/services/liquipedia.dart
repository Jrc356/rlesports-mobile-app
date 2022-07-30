import 'dart:convert';
import 'package:http/http.dart' as http;

const String api = "https://liquipedia.net/rocketleague/api.php";
const JsonDecoder decoder = JsonDecoder();

Future<Map<String, String>> getImageUrls(List<String> playerNames) async {
  Map<String, String> imageUrls = {};
  String titles = "";
  for (String player in playerNames) {
    titles += player;
    if (playerNames.indexOf(player) != playerNames.length - 1) {
      titles += "|";
    }
  }

  String url = "$api?action=query&titles=$titles&format=json&prop=pageprops";

  http.Response res = await http.get(Uri.parse(url));
  if (res.statusCode == 200) {
    var data = jsonDecode(res.body);

    for (var page in data["query"]["pages"].entries) {
      String imgUrl = "";
      if (page.value.containsKey("pageprops") &&
          page.value["pageprops"].containsKey("metaimageurl")) {
        imgUrl = page.value["pageprops"]["metaimageurl"];
      }

      if (imgUrl.contains("PlayerImagePlaceholder") || imgUrl.isEmpty) {
        imgUrl =
            "https://media.sketchfab.com/models/9910f0a5d158425bbc7deb60c7a81f69/thumbnails/14ce0f826a6f4e3d9f2fb5921cd98a74/c5a09b29d7f649559972363859e7c80f.jpeg";
      }

      imageUrls[page.value["title"]] = imgUrl;
    }
  } else {
    throw Exception("Received ${res.statusCode} code from octane: ${res.body}");
  }

  return imageUrls;
}
