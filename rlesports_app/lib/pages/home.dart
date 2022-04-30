import 'package:flutter/material.dart';
import 'package:rlesports_app/models/match.dart';
import 'package:rlesports_app/theme/colors.dart';
import 'package:rlesports_app/widgets/active_match.dart';
import 'package:rlesports_app/widgets/frosted_pane.dart';
import 'package:rlesports_app/widgets/scheduled_match.dart';

class HomePage extends StatelessWidget {
  final int menuIndex;
  const HomePage({Key? key, this.menuIndex = 0}) : super(key: key);

  List<Match> getActiveMatches() {
    // TODO: Get this from a server or something
    return getDummyActiveMatches();
  }

  List<Match> getScheduledMatches() {
    // TODO: Get this from a server or something
    return getDummyScheduledMatches();
  }

  @override
  Widget build(BuildContext context) {
    List<Match> activeMatches = getActiveMatches();
    List<Match> scheduledMatches = getScheduledMatches();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.rlOrange.withOpacity(.8),
            AppColors.rlBlue.withOpacity(.8),
          ],
        ),
      ),
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          FrostedPane(
            child: Column(
              children: List.generate(activeMatches.length + 1, (index) {
                if (index == 0) {
                  return Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: const Text("Active Matches"));
                }
                return ActiveMatch(match: activeMatches[index - 1]);
              }),
            ),
          ),
          FrostedPane(
            child: Column(
              children: List.generate(scheduledMatches.length + 1, (index) {
                if (index == 0) {
                  return Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: const Text("Scheduled Matches"));
                }
                return ScheduledMatch(match: scheduledMatches[index - 1]);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
