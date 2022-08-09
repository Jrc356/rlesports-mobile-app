import 'package:flutter/material.dart';
import 'package:rlesports_app/models/match.dart';
import 'package:rlesports_app/theme/colors.dart';
import 'package:rlesports_app/widgets/active_match.dart';
import 'package:rlesports_app/widgets/background.dart';
import 'package:rlesports_app/widgets/frosted_pane.dart';
import 'package:rlesports_app/widgets/past_match.dart';
import 'package:rlesports_app/widgets/scheduled_match.dart';
import 'package:rlesports_app/services/octanegg.dart' as octanegg;

class HomePage extends StatelessWidget {
  final int menuIndex;
  const HomePage({Key? key, this.menuIndex = 0}) : super(key: key);

  // Get active matches
  Future<List<Match>> getActiveMatches() async {
    DateTime end = DateTime.now().add(const Duration(minutes: 30)).toUtc();
    DateTime start = DateTime.now().toUtc();
    return octanegg.getMatches(before: end, after: start);
  }

  // Get scheduled matches
  Future<List<Match>> getScheduledMatches() async {
    // Scheduled matches should not include active matches
    DateTime start = DateTime.now().toUtc().add(const Duration(minutes: 30));
    return await octanegg.getMatches(after: start);
  }

  // Get past matches
  Future<List<Match>> getPastMatches() async {
    // Scheduled matches should not include active matches
    DateTime end = DateTime.now().toUtc();
    DateTime start = DateTime.now().toUtc().subtract(const Duration(days: 7));
    return await octanegg.getMatches(
      before: end,
      after: start,
      sortBy: "date",
      asc: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: ListView(
        children: <Widget>[
          // Active Matches
          // TODO: Split by event
          FutureBuilder(
            future: getActiveMatches(),
            builder: (BuildContext context, AsyncSnapshot<List<Match>> snap) {
              // TODO: I don't like this, too many loading things
              if (snap.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return FrostedPane(
                  child: Column(
                    children: List.generate(
                      snap.data!.length + 2,
                      (index) {
                        if (index == 0) {
                          return Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: const Text("Active Matches"));
                        }

                        if (snap.data!.isEmpty) {
                          return Container(
                              alignment: Alignment.center,
                              height: 106.25,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.5), //color of shadow
                                    spreadRadius: 2, //spread radius
                                    blurRadius: 7, // blur radius
                                    offset: const Offset(
                                        1, 3), // changes position of shadow
                                  ),
                                ],
                                gradient: AppColors.whiteGradient,
                              ),
                              child: const Text("No Active Matches"));
                        } else {
                          return ActiveMatch(match: snap.data![index - 2]);
                        }
                      },
                      growable: false,
                    ),
                  ),
                );
              }
            },
          ),

          // Scheduled Matches
          // TODO: Split by event
          // TODO: Split by day
          FutureBuilder(
            future: getScheduledMatches(),
            builder: (BuildContext context, AsyncSnapshot<List<Match>> snap) {
              if (snap.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return FrostedPane(
                  child: Column(
                    children: List.generate(
                      snap.data!.length + 1,
                      (index) {
                        if (index == 0) {
                          return Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: const Text("Scheduled Matches"));
                        }
                        return ScheduledMatch(match: snap.data![index - 1]);
                      },
                      growable: false,
                    ),
                  ),
                );
              }
            },
          ),
          // Past Matches
          // TODO: Split by event
          // TODO: Split by day
          FutureBuilder(
            future: getPastMatches(),
            builder: (BuildContext context, AsyncSnapshot<List<Match>> snap) {
              if (snap.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return FrostedPane(
                  child: Column(
                    children: List.generate(
                      snap.data!.length + 1,
                      (index) {
                        if (index == 0) {
                          return Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: const Text("Past Matches"));
                        }
                        return PastMatch(match: snap.data![index - 1]);
                      },
                      growable: false,
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
