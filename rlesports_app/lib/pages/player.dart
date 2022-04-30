import 'package:flutter/material.dart';
import 'package:rlesports_app/models/player.dart';
import 'package:rlesports_app/services/octanegg.dart' as octanegg;
import 'package:rlesports_app/theme/colors.dart';
import 'package:rlesports_app/widgets/app_bar.dart';
import 'package:rlesports_app/widgets/frosted_pane.dart';
import 'package:rlesports_app/widgets/player_details.dart';
import 'package:rlesports_app/widgets/player_list_item.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({Key? key}) : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late Future<List<Player>> _players;
  int _page = 1;

  Future<List<Player>> updateAndGetList(String page) async {
    return octanegg.getPlayers(page: page);
  }

  @override
  void initState() {
    super.initState();
    // initial load
    _players = updateAndGetList(_page.toString());
  }

  @override
  Widget build(BuildContext context) {
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
        child: FutureBuilder(
          future: _players,
          builder:
              (BuildContext context, AsyncSnapshot<List<Player>> snapshot) {
            if (snapshot.hasError) {
              return const FrostedPane(
                child: Text("An error occurred"),
              );
            }

            if (snapshot.data == null) {
              return const CircularProgressIndicator();
            }

            final List<Player> items = snapshot.data!;
            return FrostedPane(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: items.length,
                itemBuilder: ((context, index) {
                  return PlayerListItem(player: items[index]);
                }),
              ),
            );
          },
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
      appBar: const RLAppBar(useBackButton: true),
      body: PlayerDetails(player: player),
    );
  }
}
