import 'package:flutter/material.dart';
import 'package:rlesports_app/models/player.dart';
import 'package:rlesports_app/pages/player.dart';
import 'package:rlesports_app/theme/colors.dart';

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
                      PlayerDetailsPage(player: player)),
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
              Container(
                // Player image
                width: 53.13,
                height: 53.12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: Image.network(player.imageUrl).image,
                  ),
                ),
              ),
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
                      Text(
                        player.team,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
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