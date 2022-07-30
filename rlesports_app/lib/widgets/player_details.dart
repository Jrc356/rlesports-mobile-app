import 'package:flutter/material.dart';
import 'package:rlesports_app/models/player.dart';
import 'package:rlesports_app/theme/colors.dart';
import 'package:rlesports_app/widgets/background.dart';
import 'package:rlesports_app/widgets/frosted_pane.dart';
import 'package:rlesports_app/widgets/player_image.dart';

class PlayerDetails extends StatelessWidget {
  final Player player;
  const PlayerDetails({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
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
                        player: player,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: PlayerImage(
                      player: player,
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
    );
  }
}

class DetailsBox extends StatelessWidget {
  final Player player;
  const DetailsBox({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: AppColors.whiteGradient,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 75),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              // Player Alias
              Text(
                player.name,
                style: const TextStyle(
                  fontSize: 45.5,
                  decoration: TextDecoration.underline,
                ),
              ),
              // Other player details
              ...player
                  .getDetails()
                  .entries
                  .map(
                    (entry) => entry.key != "imageUrl"
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "${entry.key}: ",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: entry.value,
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
