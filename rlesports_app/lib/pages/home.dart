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
      child: Center(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            FrostedPane(
              label: "Active Matches",
              child: Column(
                children:
                    activeMatches.map((e) => ActiveMatch(match: e)).toList(),
              ),
            ),
            FrostedPane(
              label: "Schedule",
              child: Column(
                children: scheduledMatches
                    .map((e) => ScheduledMatch(match: e))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
