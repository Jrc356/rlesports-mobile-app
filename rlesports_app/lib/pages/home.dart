import 'package:flutter/material.dart';
import 'package:rlesports_app/assets/colors.dart';
import 'package:rlesports_app/widgets/active_match.dart';
import 'package:rlesports_app/widgets/app_bar.dart';
import 'package:rlesports_app/widgets/bottom_nav.dart';
import 'package:rlesports_app/widgets/frosted_pane.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RLAppBar(),
      bottomNavigationBar: const BottomNavBar(),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FrostedPane(
                label: "Active Matches",
                child: Column(
                  children: <ActiveMatch>[
                    ActiveMatch(
                      blueTeamImage: Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/NRG_Esports_logo.svg/1200px-NRG_Esports_logo.svg.png",
                        width: 70,
                        height: 70,
                      ),
                      orangeTeamImage: Image.network(
                        "https://liquipedia.net/commons/images/thumb/d/d3/G2_Esports_2019_lightmode.png/600px-G2_Esports_2019_lightmode.png",
                        width: 70,
                        height: 70,
                      ),
                      bestOf: 7,
                      blueTeamScore: 2,
                      orangeTeamScore: 6,
                      blueTeamSetScore: 2,
                      orangeTeamSetScore: 3,
                      timeRemaining: '3:40',
                    ),
                    ActiveMatch(
                      blueTeamImage: Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Team_Envy_logo.svg/1024px-Team_Envy_logo.svg.png",
                        width: 70,
                        height: 70,
                      ),
                      orangeTeamImage: Image.network(
                        "https://assets-global.website-files.com/605e2c8c6b591c8ec12559d4/60b801d8faf4750ac09f6edd_SSG1000X1000.png",
                        width: 70,
                        height: 70,
                      ),
                      bestOf: 7,
                      blueTeamScore: 0,
                      orangeTeamScore: 5,
                      blueTeamSetScore: 1,
                      orangeTeamSetScore: 3,
                      timeRemaining: '2:10',
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
