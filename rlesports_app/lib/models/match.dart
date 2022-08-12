import 'package:rlesports_app/models/game.dart';
import 'package:rlesports_app/models/team.dart';

class Match {
  final int bestOf;
  final int? orangeTeamScore,
      orangeTeamSetScore,
      blueTeamScore,
      blueTeamSetScore;
  final String? timeRemaining, tier, eventName;
  final DateTime scheduledDateTime;
  final Team blueTeam, orangeTeam;
  final List<Game> games;

  Match({
    required this.bestOf,
    this.timeRemaining,
    this.orangeTeamScore,
    this.orangeTeamSetScore,
    this.blueTeamScore,
    this.blueTeamSetScore,
    required this.orangeTeam,
    required this.blueTeam,
    required this.scheduledDateTime,
    this.tier,
    this.eventName,
    this.games = const [],
  });
}
