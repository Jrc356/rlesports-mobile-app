import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rlesports_app/models/player.dart';
import 'package:rlesports_app/services/liquipedia.dart' as liquid;

const String api = "https://zsr.octane.gg";
const JsonDecoder decoder = JsonDecoder();

Future<http.Response> request(
    {required String endpoint, Map<String, String>? params}) {
  String url = "$api/$endpoint?";

  if (params != null) {
    for (var entry in params.entries) {
      url += "${entry.key}=${entry.value}&";
    }
  }

  return http.get(Uri.parse(url));
}

Future<List<Player>> getPlayers({int page = 1}) async {
  List<Player> players = [];

  http.Response res = await request(endpoint: "players", params: {
    "perPage": "25",
    "page": page.toString(),
  });

  if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    var playerData = data["players"];

    // get Liquipedia images
    List<String> playerNames = [];
    for (var player in playerData) {
      playerNames.add(player["tag"]);
    }
    Map<String, String?> imagesUrls = await liquid.getImageUrls(playerNames);

    for (var player in playerData) {
      players.add(
        Player(
          name: player["tag"].trim().toString(),
          irlName: player["name"].toString(),
          team: player["team"]?["name"].toString(),
          isCoach: player.containsKey("coach") && player["coach"] == true,
          imageUrl: imagesUrls[player["tag"]] ??
              "https://media.sketchfab.com/models/9910f0a5d158425bbc7deb60c7a81f69/thumbnails/14ce0f826a6f4e3d9f2fb5921cd98a74/c5a09b29d7f649559972363859e7c80f.jpeg",
          nationality: player["country"].toString(),
        ),
      );
    }
  } else {
    throw Exception("Received ${res.statusCode} code from octane: ${res.body}");
  }

  return players;
}
