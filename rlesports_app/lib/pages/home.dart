import 'package:flutter/material.dart';
import 'package:rlesports_app/models/match.dart';
import 'package:rlesports_app/theme/colors.dart';
import 'package:rlesports_app/widgets/active_match.dart';
import 'package:rlesports_app/widgets/background.dart';
import 'package:rlesports_app/widgets/clickable_item.dart';
import 'package:rlesports_app/widgets/frosted_pane.dart';
import 'package:rlesports_app/widgets/past_match.dart';
import 'package:rlesports_app/widgets/scheduled_match.dart';
import 'package:rlesports_app/services/octanegg.dart' as octanegg;

class HomePage extends StatelessWidget {
  final int menuIndex;
  const HomePage({Key? key, this.menuIndex = 0}) : super(key: key);

  // Get active matches
  Future<List<Match>> getActiveMatches() async {
    DateTime now = DateTime.now();
    DateTime end = DateTime(now.year, now.month, now.day, now.hour).toUtc();
    return octanegg.getMatches(before: end, after: end);
  }

  // Get scheduled matches
  Future<List<Match>> getScheduledMatches() async {
    // Scheduled matches should not include active matches
    DateTime now = DateTime.now();
    DateTime start =
        DateTime(now.year, now.month, now.day, now.hour + 1).toUtc();
    return await octanegg.getMatches(after: start);
  }

  // Get past matches
  Future<List<Match>> getPastMatches() async {
    DateTime now = DateTime.now();
    DateTime end = DateTime(now.year, now.month, now.day, now.hour - 1).toUtc();
    DateTime start = DateTime.now().toUtc().subtract(const Duration(days: 7));
    return await octanegg.getMatches(
      before: end,
      after: start,
      sortBy: "date",
      asc: false,
    );
  }

  Future<Map<String, List<Match>>> getAllMatches() async {
    return {
      "active": await getActiveMatches(),
      "scheduled": await getScheduledMatches(),
      "past": await getPastMatches(),
    };
  }

  Widget buildActiveMatches(List<Match> matches) {
    return FrostedPane(
      child: Column(
        children: List.generate(
          matches.length + 1,
          (index) {
            if (index == 0) {
              return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Column(
                    children: const [
                      Text("Active Matches"),
                      Divider(color: Colors.black),
                    ],
                  ));
            }

            if (matches.isEmpty) {
              return const ClickableItem(
                isClickable: false,
                child: Text("No Active Matches"),
              );
            } else {
              return ActiveMatch(match: matches[index - 1]);
            }
          },
          growable: false,
        ),
      ),
    );
  }

  Widget buildScheduledMatches(List<Match> matches) {
    // TODO: Split by event
    // TODO: Split by day
    return FrostedPane(
      child: Column(
        children: List.generate(
          matches.length + 1,
          (index) {
            if (index == 0) {
              return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Column(
                    children: const [
                      Text("Scheduled Matches"),
                      Divider(color: Colors.black),
                    ],
                  ));
            }
            return ScheduledMatch(match: matches[index - 1]);
          },
          growable: false,
        ),
      ),
    );
  }

  Widget buildPastMatches(List<Match> matches) {
    // TODO: Split by event
    // TODO: Split by day
    return FrostedPane(
      child: Column(
        children: List.generate(
          matches.length + 1,
          (index) {
            if (index == 0) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Column(
                  children: const [
                    Text("Past Matches"),
                    Divider(color: Colors.black),
                  ],
                ),
              );
            }
            return PastMatch(match: matches[index - 1]);
          },
          growable: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: FutureBuilder(
        future: getAllMatches(),
        builder: (
          BuildContext context,
          AsyncSnapshot<Map<String, List<Match>>> snap,
        ) {
          if (snap.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              children: <Widget>[
                buildActiveMatches(snap.data!["active"]!),
                buildScheduledMatches(snap.data!["scheduled"]!),
                buildPastMatches(snap.data!["past"]!),
              ],
            );
          }
        },
      ),
    );
  }
}
