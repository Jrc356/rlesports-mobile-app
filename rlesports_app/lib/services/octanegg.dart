import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rlesports_app/models/match.dart';
import 'package:rlesports_app/models/player.dart';
import 'package:rlesports_app/models/team.dart';
import 'package:rlesports_app/services/liquipedia.dart' as liquid;
import 'package:rlesports_app/constants.dart';

const String api = "https://zsr.octane.gg";
const JsonDecoder decoder = JsonDecoder();

Future<http.Response> request({
  required String endpoint,
  Map<String, String>? params,
  String? customParams,
}) {
  String url = "$api/$endpoint?";

  if (params != null) {
    for (var entry in params.entries) {
      url += "${entry.key}=${entry.value}&";
    }
  }

  if (customParams != null) {
    url += customParams;
  }

  return http.get(Uri.parse(url));
}

// getMatches gets a list of matches matching the specified criteria
// TODO: Add more criteria params
Future<List<Match>> getMatches({
  List<String>? tiers,
  DateTime? before,
  DateTime? after,
  String? sortBy,
  bool asc = true,
  int page = 1,
}) async {
  List<Match> matches = [];

  Map<String, String> reqParams = {
    "perPage": "100",
    "page": page.toString(),
  };

  if (before != null) {
    reqParams["before"] = before.toUtc().toIso8601String();
  }

  if (after != null) {
    reqParams["after"] = after.toUtc().toIso8601String();
  }

  String customTierParam = "";
  tiers ??= ["S"];
  for (String tier in tiers) {
    customTierParam += "tier=$tier&";
  }

  if (sortBy != null) {
    reqParams["sort"] = "$sortBy:${asc ? "asc" : "desc"}";
  }

  // Get all matches for specified teirs
  http.Response res = await request(
    endpoint: "matches",
    params: reqParams,
    customParams: customTierParam,
  );
  if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    if (data["matches"].length > 0) {
      for (var matchData in data["matches"]) {
        Team orangeTeam = Team(name: "TBD", imageUrl: defaultImage);
        Team blueTeam = Team(name: "TBD", imageUrl: defaultImage);

        // Get orange team
        if (matchData.containsKey("orange")) {
          var odat = matchData["orange"]["team"]["team"];
          orangeTeam = Team(
            name: odat["name"],
            imageUrl: odat["image"] ?? defaultImage,
            region: odat["region"],
          );
        }

        // Get blue team
        if (matchData.containsKey("blue")) {
          var bdat = matchData["blue"]["team"]["team"];
          blueTeam = Team(
            name: bdat["name"],
            imageUrl: bdat["image"] ?? defaultImage,
            region: bdat["region"],
          );
        }

        // Get scheduled date
        DateTime date = DateTime.tryParse(matchData["date"]) ?? DateTime.now();

        // Get event data
        String? eventName, eventStage;
        if (matchData.containsKey("event")) {
          eventName = matchData["event"]["name"];
        }
        if (matchData.containsKey("stage")) {
          eventStage = matchData["stage"]["name"];
        }

        // Get set score
        int blueSetScore = 0;
        int orangeSetScore = 0;
        if (matchData.containsKey("games")) {
          for (var game in matchData["games"]) {
            if (game["blue"] > game["orange"]) {
              blueSetScore = blueSetScore + 1;
            } else {
              orangeSetScore = orangeSetScore + 1;
            }
          }
        }

        // TODO: probably not good but skip the match if both teams are TBD
        if (blueTeam.name == "TBD" && orangeTeam.name == "TBD") {
          continue;
        }

        // Create match
        matches.add(
          Match(
            octaneId: matchData["_id"],
            bestOf: matchData["format"]["length"],
            orangeTeam: orangeTeam,
            orangeTeamSetScore: orangeSetScore,
            blueTeam: blueTeam,
            blueTeamSetScore: blueSetScore,
            scheduledDateTime: date,
            eventName: eventName,
            eventStage: eventStage,
          ),
        );
      }
    }
  }

  return matches;
}

// getPlayers retrieves all players matching the specified criteria
// TODO: Add criteria params
Future<List<Player>> getPlayers({int page = 1, int perPage = 50}) async {
  List<Player> players = [];

  // TODO: Would love to sort this by tag but seems the sort parameter is broken
  // see the discord: https://discord.com/channels/381183995423227904/833408623886598184/1003515688067014777
  http.Response res = await request(endpoint: "players", params: {
    "perPage": perPage.toString(),
    "page": page.toString(),
    "sort": "tag:asc",
    "relevant": "true",
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
          name: player["tag"].toString().trim(),
          irlName: player["name"].toString().trim(),
          team: player["team"]?["name"].toString().trim(),
          isCoach: player.containsKey("coach") && player["coach"] == true,
          imageUrl: imagesUrls[player["tag"]] ?? defaultImage,
          nationality: player["country"].toString().trim(),
        ),
      );
    }
  } else {
    throw Exception("Received ${res.statusCode} code from octane: ${res.body}");
  }

  return players;
}

// getTeams gets teams matching the specified criteria
// TODO: Add criteria params
Future<List<Team>> getTeams({int page = 1, int perPage = 50}) async {
  List<Team> teams = [];

  // see the discord thread: https://discord.com/channels/381183995423227904/833408623886598184/1003515688067014777
  http.Response res = await request(endpoint: "teams", params: {
    "perPage": perPage.toString(),
    "page": page.toString(),
    "sort": "name:asc",
    "relevant": "true",
  });

  if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    for (var team in data["teams"]) {
      Team teamToAdd = Team(
        name: team["name"],
        imageUrl: team["image"] ?? defaultImage,
        region: team["region"],
      );
      if (!teams.any((element) => element.name == teamToAdd.name)) {
        teams.add(teamToAdd);
      }
    }
  } else {
    throw Exception("Received ${res.statusCode} code from octane: ${res.body}");
  }

  return teams;
}
