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

Future<List<Player>> getPlayers({String page = "1"}) async {
  List<Player> players = [];

  http.Response res = await request(endpoint: "players", params: {
    "perPage": "25",
    "page": page,
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
          name: player["tag"].trim(),
          irlName: player["name"],
          team: player["team"]?["name"],
          imageUrl: imagesUrls[player["tag"]],
          nationality: player["country"],
        ),
      );
    }
  } else {
    throw Exception("Received ${res.statusCode} code from octane: ${res.body}");
  }

  return players;
}
