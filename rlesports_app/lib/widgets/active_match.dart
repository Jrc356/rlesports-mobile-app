import 'package:flutter/material.dart';
import 'package:rlesports_app/assets/colors.dart';

class BestOfSetMarkers extends StatelessWidget {
  final Color color;
  final int bestOf;
  final int hasWon;
  final bool reverse;
  const BestOfSetMarkers({
    Key? key,
    required this.color,
    required this.hasWon,
    this.bestOf = 5,
    this.reverse = false,
  }) : super(key: key);

  Container makeMarker(bool enabled) {
    return Container(
      decoration: BoxDecoration(
        color: enabled ? color : AppColors.whiteGradient_1,
        border: Border.all(color: AppColors.matteGrey, width: 1.5),
      ),
      height: 13.28,
      width: 26.56,
    );
  }

  @override
  Widget build(BuildContext context) {
    int bo = (bestOf / 2).ceil();

    List<Container> markers = <Container>[];
    if (reverse) {
      for (int i = 0; i < bo; i++) {
        markers.insert(0, makeMarker(i < hasWon));
      }
    } else {
      for (int i = 0; i < bo; i++) {
        markers.add(makeMarker(i < hasWon));
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: markers,
    );
  }
}

class ActiveMatch extends StatelessWidget {
  final int bestOf;
  final String timeRemaining;
  final Image orangeTeamImage;
  final int orangeTeamScore;
  final int orangeTeamSetScore;
  final int blueTeamScore;
  final int blueTeamSetScore;
  final Image blueTeamImage;

  const ActiveMatch(
      {Key? key,
      required this.bestOf,
      required this.timeRemaining,
      required this.orangeTeamImage,
      required this.orangeTeamScore,
      required this.orangeTeamSetScore,
      required this.blueTeamScore,
      required this.blueTeamSetScore,
      required this.blueTeamImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: .85 * MediaQuery.of(context).size.width,
      height: 106.25,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 5),
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
          gradient: AppColors.whiteGradient),
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            Align(
              // Orange current game score
              alignment: const Alignment(-0.4, -0.4),
              child: Text(
                orangeTeamScore.toString(),
                style: const TextStyle(fontSize: 31.88),
              ),
            ),
            Align(
              // Game number
              alignment: const Alignment(0, -1),
              child: Text(
                "Game " +
                    (blueTeamSetScore + orangeTeamSetScore + 1).toString(),
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
              // remaining match time
              alignment: const Alignment(0, 1),
              child: Text(
                timeRemaining,
                style: const TextStyle(fontSize: 15.94),
              ),
            ),
            Align(
              // Blue team current score
              alignment: const Alignment(0.4, -0.4),
              child: Text(
                blueTeamScore.toString(),
                style: const TextStyle(fontSize: 31.88),
              ),
            ),
            Align(
              // Orange Team Image
              alignment: const Alignment(-0.9, -1.5),
              child: orangeTeamImage,
            ),
            Align(
              // Blue Team Image
              alignment: const Alignment(0.9, -1.5),
              child: blueTeamImage,
            ),
            Align(
              // Set Markers
              alignment: const Alignment(1, 1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    BestOfSetMarkers(
                      // Orange team set markers
                      color: AppColors.rlOrange,
                      hasWon: orangeTeamSetScore,
                      bestOf: bestOf,
                      reverse: true,
                    ),
                    const Expanded(child: SizedBox()),
                    BestOfSetMarkers(
                      // Blue team set markers
                      color: AppColors.rlBlue,
                      hasWon: blueTeamSetScore,
                      bestOf: bestOf,
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
