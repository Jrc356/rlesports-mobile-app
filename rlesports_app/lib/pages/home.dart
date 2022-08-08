import 'package:flutter/material.dart';
import 'package:rlesports_app/models/match.dart';
import 'package:rlesports_app/widgets/active_match.dart';
import 'package:rlesports_app/widgets/background.dart';
import 'package:rlesports_app/widgets/frosted_pane.dart';
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

  Future<List<Match>> getScheduledMatches() async {
    // Scheduled matches should not include active matches
    DateTime start = DateTime.now().toUtc().add(const Duration(minutes: 30));
    return await octanegg.getMatches(after: start);
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: ListView(
        children: <Widget>[
          // Active Matches
          FutureBuilder(
            future: getActiveMatches(),
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
                              child: const Text("Active Matches"));
                        }
                        return ActiveMatch(match: snap.data![index - 1]);
                      },
                    ),
                  ),
                );
              }
            },
          ),

          // Scheduled Matches
          FutureBuilder(
            future: getScheduledMatches(),
            builder: (BuildContext context, AsyncSnapshot<List<Match>> snap) {
              if (snap.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return FrostedPane(
                  child: Column(
                    children: List.generate(snap.data!.length + 1, (index) {
                      if (index == 0) {
                        return Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: const Text("Scheduled Matches"));
                      }
                      return ScheduledMatch(match: snap.data![index - 1]);
                    }),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
  // child:
  //     FrostedPane(
  //       child: Column(
  //         children: List.generate(scheduledMatches.length + 1, (index) {
  //           if (index == 0) {
  //             return Container(
  //                 padding: const EdgeInsets.symmetric(vertical: 5),
  //                 child: const Text("Scheduled Matches"));
  //           }
  //           return ScheduledMatch(match: scheduledMatches[index - 1]);
  //         }),
  //       ),
  // ),
  // ],
  // ),
  // ),
  // );
  // }
}
