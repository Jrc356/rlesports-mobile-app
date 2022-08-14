import 'package:flutter/material.dart';
import 'package:rlesports_app/models/match.dart';
import 'package:rlesports_app/theme/colors.dart';
import 'package:rlesports_app/widgets/best_of_set_markers.dart';
import 'package:rlesports_app/widgets/clickable_item.dart';

class PastMatch extends StatelessWidget {
  final Match match;

  const PastMatch({
    Key? key,
    required this.match,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClickableItem(
      child: Stack(
        children: <Widget>[
          // event stage text
          Align(
            alignment: const Alignment(-1, 0),
            child: SizedBox(
              width: 90,
              child: Text(
                match.eventStage.toString(),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 5,
              ),
            ),
          ),

          // vs text
          const Align(
            alignment: Alignment(0.25, 0),
            child: Text(
              "vs.",
              style: TextStyle(fontSize: 15.94),
            ),
          ),

          //*** Orange Team
          // Image
          Align(
            alignment: const Alignment(-0.2, -1),
            child: Image.network(
              match.orangeTeam.imageUrl,
              width: 60,
              height: 60,
            ),
          ),
          // Set markers
          Padding(
            padding: const EdgeInsets.only(right: 135),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BestOfSetMarkers(
                color: AppColors.rlOrange,
                hasWon: match.orangeTeamSetScore!,
                bestOf: match.bestOf,
                reverse: true,
                alignment: MainAxisAlignment.end,
              ),
            ),
          ),

          //*** Blue Team
          // Image
          Align(
            alignment: const Alignment(0.8, -1),
            child: Image.network(
              match.blueTeam.imageUrl,
              width: 60,
              height: 60,
            ),
          ),
          // Set markers
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BestOfSetMarkers(
                color: AppColors.rlBlue,
                hasWon: match.blueTeamSetScore!,
                bestOf: match.bestOf,
                alignment: MainAxisAlignment.end,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
