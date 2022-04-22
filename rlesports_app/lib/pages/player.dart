import 'package:flutter/material.dart';
import 'package:rlesports_app/models/player.dart';
import 'package:rlesports_app/theme/colors.dart';
import 'package:rlesports_app/widgets/app_bar.dart';
import 'package:rlesports_app/widgets/frosted_pane.dart';
import 'package:rlesports_app/widgets/player_list_item.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({Key? key}) : super(key: key);

  List<Player> getPlayers() {
    // TODO: Get this from a server as well
    List<Player> players = getDummyPlayers();
    return players;
  }

  @override
  Widget build(BuildContext context) {
    List<Player> players = getPlayers();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.rlOrange.withOpacity(.8),
            AppColors.rlBlue.withOpacity(.8),
          ],
        ),
      ),
      child: Center(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            FrostedPane(
              child: Column(
                children:
                    players.map((p) => PlayerListItem(player: p)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerDetailsPage extends StatelessWidget {
  final Player player;
  const PlayerDetailsPage({
    Key? key,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RLAppBar(useBackButton: true),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.rlOrange.withOpacity(.8),
              AppColors.rlBlue.withOpacity(.8),
            ],
          ),
        ),
        child: Center(
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: const <Widget>[
              FrostedPane(
                child: Text("Test"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
