import 'package:flutter/material.dart';
import 'package:rlesports_app/models/player.dart';
import 'package:rlesports_app/pages/player.dart';
import 'package:rlesports_app/theme/colors.dart';
import 'package:rlesports_app/widgets/player_image.dart';

class PlayerListItem extends StatelessWidget {
  final Player player;

  const PlayerListItem({
    Key? key,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      PlayerDetailsView(player: player)),
            ),
          }),
      child: Container(
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
          gradient: AppColors.whiteGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              PlayerImage(player: player),
              Padding(
                  // Player name and team
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        player.name,
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      player.team != null
                          ? Text(
                              player.team!,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            )
                          : Container(),
                    ],
                  )),
              const Expanded(child: SizedBox()),
              Align(
                // favorite icon
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
