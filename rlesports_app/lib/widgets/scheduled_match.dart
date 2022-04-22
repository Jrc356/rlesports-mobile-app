import 'package:flutter/material.dart';
import 'package:rlesports_app/theme/colors.dart';
import 'package:rlesports_app/models/match.dart';

class ScheduledMatch extends StatelessWidget {
  final Match match;

  const ScheduledMatch({
    Key? key,
    required this.match,
  }) : super(key: key);

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
              // vs text
              alignment: const Alignment(-0.9, 0),
              child: Text(
                match.startTime!,
                style: const TextStyle(fontSize: 15.94),
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
              alignment: const Alignment(-0.5, 0),
              child: Image.network(
                match.orangeTeam.imageUrl,
                width: 70,
                height: 70,
              ),
            ),
            Align(
              // Blue Team Image
              alignment: const Alignment(0.5, 0),
              child: Image.network(
                match.blueTeam.imageUrl,
                width: 70,
                height: 70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
