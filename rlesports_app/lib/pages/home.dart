import 'package:flutter/material.dart';
import 'package:rlesports_app/models/match.dart';
import 'package:rlesports_app/widgets/active_match.dart';
import 'package:rlesports_app/widgets/background.dart';
import 'package:rlesports_app/widgets/clickable_item.dart';
import 'package:rlesports_app/widgets/frosted_pane.dart';
import 'package:rlesports_app/widgets/past_match.dart';
import 'package:rlesports_app/widgets/scheduled_match.dart';
import 'package:rlesports_app/services/octanegg.dart' as octanegg;

// Get active matches
Future<List<Match>> getActiveMatches() async {
  // Not sure how accurate this is
  DateTime now = DateTime.now();
  DateTime before = DateTime(now.year, now.month, now.day, now.hour).toUtc();
  DateTime after = DateTime(now.year, now.month, now.day, now.hour - 1).toUtc();
  return octanegg.getMatches(before: before, after: after);
}

// Get scheduled matches
Future<List<Match>> getScheduledMatches() async {
  // Scheduled matches should not include active matches
  return await octanegg.getMatches(after: DateTime.now().toUtc());
}

// Get past matches
Future<List<Match>> getPastMatches() async {
  DateTime now = DateTime.now();
  DateTime before =
      DateTime(now.year, now.month, now.day, now.hour + 1).toUtc();
  return await octanegg.getMatches(before: before, sortBy: "date", asc: false);
}

Future<Map<String, List<Match>>> getAllMatches() async {
  print("Getting all matches...");
  return {
    "active": await getActiveMatches(),
    "scheduled": await getScheduledMatches(),
    "past": await getPastMatches(),
  };
}

class HomePage extends StatefulWidget {
  final int menuIndex;
  const HomePage({Key? key, this.menuIndex = 0}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Map<String, List<Match>>> _allMatches = getAllMatches();

  Widget buildActiveMatches(List<Match> matches) {
    String lastEvent = "";
    return FrostedPane(
      child: Column(
        children: List.generate(
          matches.length + 1,
          (index) {
            if (index == 0) {
              return Column(
                children: [
                  const Text(
                    "Active Matches",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Divider(color: Colors.black),
                  ),
                  if (matches.isEmpty)
                    const ClickableItem(
                      isClickable: false,
                      child: Text("No Active Matches"),
                    )
                ],
              );
            }

            if (matches[index - 1].eventName != lastEvent) {
              lastEvent = matches[index - 1].eventName.toString();
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: index - 1 == 0 ? 5 : 30),
                    child: Text(matches[index - 1].eventName.toString()),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 60,
                      right: 60,
                      top: 5,
                    ),
                    child: Divider(color: Colors.black),
                  ),
                  ActiveMatch(match: matches[index - 1]),
                ],
              );
            }
            return ActiveMatch(match: matches[index - 1]);
          },
          growable: false,
        ),
      ),
    );
  }

  Widget buildScheduledMatches(List<Match> matches) {
    String lastEvent = "";
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
                      Text(
                        "Scheduled Matches",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Divider(color: Colors.black),
                    ],
                  ));
            }

            if (matches[index - 1].eventName != lastEvent) {
              lastEvent = matches[index - 1].eventName.toString();
              return Column(children: [
                Padding(
                  padding: EdgeInsets.only(top: index - 1 == 0 ? 5 : 30),
                  child: Text(matches[index - 1].eventName.toString()),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 60,
                    right: 60,
                    top: 5,
                  ),
                  child: Divider(color: Colors.black),
                ),
                ScheduledMatch(match: matches[index - 1]),
              ]);
            }
            return ScheduledMatch(match: matches[index - 1]);
          },
          growable: false,
        ),
      ),
    );
  }

  Widget buildPastMatches(List<Match> matches) {
    String lastEvent = "";
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
                    Text(
                      "Past Matches",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Divider(color: Colors.black),
                  ],
                ),
              );
            }

            if (matches[index - 1].eventName != lastEvent) {
              lastEvent = matches[index - 1].eventName.toString();
              return Column(children: [
                Padding(
                  padding: EdgeInsets.only(top: index - 1 == 0 ? 5 : 30),
                  child: Text(
                    matches[index - 1].eventName.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 60,
                    right: 60,
                    top: 5,
                  ),
                  child: Divider(color: Colors.black),
                ),
              ]);
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
      child: RefreshIndicator(
        onRefresh: () {
          return Future(() {
            setState(
              () {
                _allMatches = getAllMatches();
              },
            );
          });
        },
        child: FutureBuilder(
          future: _allMatches,
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
      ),
    );
  }
}
