import 'package:flutter/material.dart';
import 'package:rlesports_app/theme/colors.dart';
import 'package:rlesports_app/models/match.dart';
import 'package:intl/intl.dart';

class ScheduledMatch extends StatelessWidget {
  final Match match;

  const ScheduledMatch({
    Key? key,
    required this.match,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: include event information
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
          gradient: AppColors.whiteGradient),
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            Align(
              // date text
              alignment: const Alignment(-0.9, -0.5),
              child: Text(
                DateFormat().add_yMd().format(match.scheduledDateTime),
                style: const TextStyle(fontSize: 15.94),
              ),
            ),
            Align(
              // time text
              alignment: const Alignment(-0.9, 0.5),
              child: Text(
                DateFormat().add_jm().format(match.scheduledDateTime),
                style: const TextStyle(fontSize: 15.94),
              ),
            ),
            const Align(
              // vs text
              alignment: Alignment(0.2, 0),
              child: Text(
                "vs.",
                style: TextStyle(fontSize: 15.94),
              ),
            ),
            Align(
              // Orange Team Image
              alignment: const Alignment(-0.2, 0),
              child: Image.network(
                match.orangeTeam.imageUrl,
                width: 70,
                height: 70,
              ),
            ),
            Align(
              // Blue Team Image
              alignment: const Alignment(0.7, 0),
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
