import 'package:flutter/material.dart';
import 'package:rlesports_app/models/match.dart';
import 'package:rlesports_app/theme/colors.dart';
import 'package:rlesports_app/widgets/best_of_set_markers.dart';
import 'package:rlesports_app/widgets/clickable_item.dart';

class ActiveMatch extends StatelessWidget {
  final Match match;

  const ActiveMatch({
    Key? key,
    required this.match,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClickableItem(
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            // TODO: figure out live scores somehow
            // Align(
            //   // Orange current game score
            //   alignment: const Alignment(-0.4, -0.4),
            //   child: Text(
            //     match.orangeTeamScore.toString(),
            //     style: const TextStyle(fontSize: 31.88),
            //   ),
            // ),
            Align(
              // Game number
              alignment: const Alignment(0, -1),
              child: Text(
                "Game " +
                    (match.blueTeamSetScore! + match.orangeTeamSetScore! + 1)
                        .toString(),
                style: const TextStyle(fontSize: 21.25),
              ),
            ),
            const Align(
              // vs text
              alignment: Alignment(0, 0),
              child: Text(
                "vs.",
                style: TextStyle(fontSize: 15.94),
              ),
            ),
            Align(
              // Orange Team Image
              alignment: const Alignment(-1, -1.5),
              child: Image.network(
                match.orangeTeam.imageUrl,
                width: 70,
                height: 70,
              ),
            ),
            Align(
              // Blue Team Image
              alignment: const Alignment(1, -1.5),
              child: Image.network(
                match.blueTeam.imageUrl,
                width: 70,
                height: 70,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: BestOfSetMarkers(
                  color: AppColors.rlBlue,
                  hasWon: match.blueTeamSetScore ?? 0,
                  bestOf: match.bestOf,
                  alignment: MainAxisAlignment.end,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BestOfSetMarkers(
                color: AppColors.rlOrange,
                hasWon: match.orangeTeamSetScore ?? 0,
                bestOf: match.bestOf,
                reverse: true,
                alignment: MainAxisAlignment.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
