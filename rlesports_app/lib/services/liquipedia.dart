import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rlesports_app/constants.dart';

const String api = "https://liquipedia.net/rocketleague/api.php";
const JsonDecoder decoder = JsonDecoder();
const int maxObjectsPerRequest = 50;

Future<Map<String, String>> getImageUrls(List<String> playerNames) async {
  // TODO: Need to cache these

  // Create a list of lists of player names since liquipedia limits total number of objects per request
  int m = (playerNames.length / maxObjectsPerRequest).round();
  List<List<String>> nameLists = List.generate(m, (index) {
    int start = maxObjectsPerRequest * index;
    int? end = (index + 1) * maxObjectsPerRequest;
    if ((index + 1) * maxObjectsPerRequest > playerNames.length) {
      end = null;
    }
    return playerNames.sublist(start, end);
  });

  Map<String, String> imageUrls = {};
  for (var nameList in nameLists) {
    String titles = "";
    for (String player in nameList) {
      titles += player;
      if (nameList.indexOf(player) != nameList.length - 1) {
        titles += "|";
      }
    }

    http.Response res = await http.get(Uri.parse(
        "$api?action=query&titles=$titles&format=json&prop=pageprops&ppprop=metaimageurl&redirects=true"));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);

      // There might be redirects which change the page title from what was expected
      Map<String, String> redirectedToFrom = {};
      if (data["query"].containsKey("redirects")) {
        for (var redirect in data["query"]["redirects"]) {
          redirectedToFrom[redirect["to"]] = redirect["from"];
        }
      }

      // There might be normalization which change the page title from what was expected
      Map<String, String> normalizedToFrom = {};
      if (data["query"].containsKey("normalized")) {
        for (var normal in data["query"]["normalized"]) {
          normalizedToFrom[normal["to"]] = normal["from"];
        }
      }

      for (var page in data["query"]["pages"].entries) {
        String imgUrl = defaultImage;

        if (page.value.containsKey("pageprops") &&
            page.value["pageprops"].containsKey("metaimageurl") &&
            !page.value["pageprops"]["metaimageurl"]
                .toLowerCase()
                .contains("placeholder")) {
          imgUrl = page.value["pageprops"]["metaimageurl"];
        }

        // If the title is a redirection, we need to get the original
        String title = page.value["title"];
        if (redirectedToFrom.containsKey(title)) {
          String redirectedFrom = redirectedToFrom[title].toString();
          title = redirectedFrom;
        }

        if (normalizedToFrom.containsKey(title)) {
          String normalizedFrom = normalizedToFrom[title].toString();
          title = normalizedFrom;
        }

        imageUrls[title] = imgUrl;
      }
      sleep(const Duration(seconds: 2));
    } else {
      throw Exception(
          "Received ${res.statusCode} code from liquipedia: ${res.body}");
    }
  }

  return imageUrls;
}
