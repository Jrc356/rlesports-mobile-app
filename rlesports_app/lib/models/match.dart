import 'package:rlesports_app/models/game.dart';
import 'package:rlesports_app/models/team.dart';

class Match {
  final int bestOf;
  final int? orangeTeamScore,
      orangeTeamSetScore,
      blueTeamScore,
      blueTeamSetScore;
  // TODO: make an event model?
  final String? timeRemaining, tier, eventName, eventStage;
  final DateTime scheduledDateTime;
  final Team blueTeam, orangeTeam;
  final List<Game> games;

  Match({
    required this.bestOf,
    required this.orangeTeam,
    required this.blueTeam,
    required this.scheduledDateTime,
    this.timeRemaining,
    this.orangeTeamScore,
    this.orangeTeamSetScore,
    this.blueTeamScore,
    this.blueTeamSetScore,
    this.tier,
    this.eventName,
    this.eventStage,
    this.games = const [],
  });
}
