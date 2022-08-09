import 'package:flutter/material.dart';
import 'package:rlesports_app/models/player.dart';
import 'package:rlesports_app/pages/player_details.dart';
import 'package:rlesports_app/services/octanegg.dart' as octanegg;
import 'package:rlesports_app/widgets/background.dart';
import 'package:rlesports_app/widgets/frosted_pane.dart';
import 'package:rlesports_app/widgets/list_item.dart';

class PlayerList extends StatefulWidget {
  // TODO: Persist player list across pages
  const PlayerList({Key? key}) : super(key: key);

  @override
  State<PlayerList> createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  List<Player> loadedPlayers = [];
  ScrollController scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.extentAfter < 400) {
        setState(() {
          octanegg.getPlayers(page: page).then((value) => setState(
                () => loadedPlayers.addAll(value),
              ));
          page++;
        });
      }
    });
    // initial load
    octanegg.getPlayers(page: page).then((value) => setState(
          () => loadedPlayers.addAll(value),
        ));
    page++;
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: loadedPlayers.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              controller: scrollController,
              physics: const ScrollPhysics(),
              child: FrostedPane(
                topMargin: 5,
                bottomMargin: 5,
                bottomPadding: 0,
                topPadding: 0,
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: loadedPlayers.length,
                  itemBuilder: ((context, index) {
                    return ListItem(
                      imageUrl: loadedPlayers[index].imageUrl.toString(),
                      text: loadedPlayers[index].name,
                      pageToPush: PlayerDetails(player: loadedPlayers[index]),
                    );
                    // );
                  }),
                ),
              ),
            ),
    );
  }
}
