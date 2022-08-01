import 'package:flutter/material.dart';
import 'package:rlesports_app/models/team.dart';
import 'package:rlesports_app/pages/team_details.dart';
import 'package:rlesports_app/services/octanegg.dart' as octanegg;
import 'package:rlesports_app/widgets/background.dart';
import 'package:rlesports_app/widgets/frosted_pane.dart';
import 'package:rlesports_app/widgets/list_item.dart';

class TeamList extends StatefulWidget {
  // TODO: Persist teams list across pages
  const TeamList({Key? key}) : super(key: key);

  @override
  State<TeamList> createState() => _TeamListState();
}

class _TeamListState extends State<TeamList> {
  List<Team> loadedTeams = [];
  ScrollController scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          octanegg
              .getTeams(page: page)
              .then((value) => setState(() => loadedTeams.addAll(value)));
          page++;
        });
      }
    });
    // initial load
    octanegg
        .getTeams(page: page)
        .then((value) => setState(() => loadedTeams.addAll(value)));
    page++;
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: loadedTeams.isEmpty
          ? const Center(child: CircularProgressIndicator())
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
                  itemCount: loadedTeams.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: (() => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TeamDetails(team: loadedTeams[index])),
                            ),
                          }),
                      child: ListItem(
                        text: loadedTeams[index].name,
                        imageUrl: loadedTeams[index].imageUrl.toString(),
                      ),
                    );
                  }),
                ),
              ),
            ),
    );
  }
}
