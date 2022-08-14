import 'package:rlesports_app/models/game.dart';
import 'package:rlesports_app/models/team.dart';

class Match {
  final String? octaneId;
  final int bestOf;
  final int orangeTeamScore,
      orangeTeamSetScore,
      blueTeamScore,
      blueTeamSetScore;
  // TODO: make an event model?
  final String? timeRemaining, tier, eventName, eventStage;
  final DateTime scheduledDateTime;
  final Team blueTeam, orangeTeam;
  final List<Game> games;

  Match({
    this.octaneId,
    required this.bestOf,
    required this.orangeTeam,
    required this.blueTeam,
    required this.scheduledDateTime,
    this.timeRemaining,
    this.tier,
    this.eventName,
    this.eventStage,
    this.orangeTeamScore = 0,
    this.orangeTeamSetScore = 0,
    this.blueTeamScore = 0,
    this.blueTeamSetScore = 0,
    this.games = const [],
  });
}
