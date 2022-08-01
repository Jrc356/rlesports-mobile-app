import 'package:flutter/material.dart';
import 'package:rlesports_app/models/team.dart';
import 'package:rlesports_app/widgets/app_bar.dart';
import 'package:rlesports_app/widgets/background.dart';
import 'package:rlesports_app/widgets/entity_image.dart';
import 'package:rlesports_app/widgets/frosted_pane.dart';
import 'package:rlesports_app/widgets/details_box.dart';

class TeamDetails extends StatelessWidget {
  final Team team;
  const TeamDetails({
    Key? key,
    required this.team,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RLAppBar(useBackButton: true),
      body: Background(
        child: Center(
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: <Widget>[
              FrostedPane(
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 125),
                      child: Align(
                          alignment: Alignment.center,
                          child: DetailsBox(
                            details: team.getDetails(),
                            title: team.name,
                          )),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: EntityImage(
                        url: team.imageUrl.toString(),
                        height: 200,
                        width: 200,
                        useShadow: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
