import 'package:flutter/material.dart';
import 'package:rlesports_app/models/match.dart';
import 'package:intl/intl.dart';
import 'package:rlesports_app/widgets/clickable_item.dart';

class ScheduledMatch extends StatelessWidget {
  final Match match;

  const ScheduledMatch({
    Key? key,
    required this.match,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: include event information
    return ClickableItem(
      child: Stack(
        children: <Widget>[
          Align(
            // date text
            alignment: const Alignment(-1, -0.5),
            child: Text(
              DateFormat().add_yMd().format(match.scheduledDateTime.toLocal()),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Align(
            // time text
            alignment: const Alignment(-1, 0.5),
            child: Text(
              DateFormat().add_jm().format(match.scheduledDateTime.toLocal()),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Align(
            // Orange Team Image
            alignment: const Alignment(0, 0),
            child: Image.network(
              match.orangeTeam.imageUrl,
              width: 70,
              height: 70,
            ),
          ),
          const Align(
            // vs text
            alignment: Alignment(0.425, 0),
            child: Text(
              "vs.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Align(
            // Blue Team Image
            alignment: const Alignment(1, 0),
            child: Image.network(
              match.blueTeam.imageUrl,
              width: 70,
              height: 70,
            ),
          ),
        ],
      ),
    );
  }
}
