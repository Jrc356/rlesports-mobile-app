import 'package:flutter/material.dart';
import 'package:rlesports_app/models/player.dart';
import 'package:rlesports_app/services/octanegg.dart' as octanegg;
import 'package:rlesports_app/widgets/app_bar.dart';
import 'package:rlesports_app/widgets/background.dart';
import 'package:rlesports_app/widgets/frosted_pane.dart';
import 'package:rlesports_app/widgets/player_details.dart';
import 'package:rlesports_app/widgets/player_list_item.dart';

class PlayerListView extends StatefulWidget {
  // TODO: Persist player list across pages
  const PlayerListView({Key? key}) : super(key: key);

  @override
  State<PlayerListView> createState() => _PlayerListViewState();
}

class _PlayerListViewState extends State<PlayerListView> {
  late Future<List<Player>> playersFuture;
  List<Player> loadedPlayers = [];
  ScrollController scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.extentAfter < 400) {
        setState(() {
          page++;
          playersFuture = octanegg.getPlayers(page: page);
        });
      }
    });
    // initial load
    playersFuture = octanegg.getPlayers(page: page);
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Center(
        child: FutureBuilder(
          future: playersFuture,
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

            final List<Player> players = snapshot.data!;
            loadedPlayers.addAll(players);
            return FrostedPane(
              bottomMargin: 0,
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                controller: scrollController,
                itemCount: loadedPlayers.length,
                itemBuilder: ((context, index) {
                  return PlayerListItem(player: loadedPlayers[index]);
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PlayerDetailsView extends StatelessWidget {
  final Player player;
  const PlayerDetailsView({
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
