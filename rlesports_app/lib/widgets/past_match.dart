import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rlesports_app/models/match.dart';
import 'package:rlesports_app/theme/colors.dart';
import 'package:rlesports_app/widgets/best_of_set_markers.dart';

class PastMatch extends StatelessWidget {
  final Match match;

  const PastMatch({
    Key? key,
    required this.match,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 106.25,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5), //color of shadow
            spreadRadius: 2, //spread radius
            blurRadius: 7, // blur radius
            offset: const Offset(1, 3), // changes position of shadow
          ),
        ],
        gradient: AppColors.whiteGradient,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            // TODO: Not sure how I like this widget
            // Think it would be good to have the scheduled date
            // and the event

            // Align(
            //   // time text
            //   alignment: const Alignment(0, 1.05),
            //   child: Text(
            //     DateFormat().add_yMd().format(match.scheduledDateTime),
            //     style: const TextStyle(fontSize: 15.94),
            //   ),
            // ),
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
              alignment: const Alignment(-0.9, -1.5),
              child: Image.network(
                match.orangeTeam.imageUrl,
                width: 70,
                height: 70,
              ),
            ),
            Align(
              // Blue Team Image
              alignment: const Alignment(0.9, -1.5),
              child: Image.network(
                match.blueTeam.imageUrl,
                width: 70,
                height: 70,
              ),
            ),
            Align(
              // Set Markers
              alignment: const Alignment(1, 1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    BestOfSetMarkers(
                      // Orange team set markers
                      color: AppColors.rlOrange,
                      hasWon: match.orangeTeamSetScore!,
                      bestOf: match.bestOf,
                      reverse: true,
                    ),
                    const Expanded(child: SizedBox()),
                    BestOfSetMarkers(
                      // Blue team set markers
                      color: AppColors.rlBlue,
                      hasWon: match.blueTeamSetScore!,
                      bestOf: match.bestOf,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
