class Match {
  final int? bestOf,
      orangeTeamScore,
      orangeTeamSetScore,
      blueTeamScore,
      blueTeamSetScore;
  final String? timeRemaining, orangeTeamImageUrl, blueTeamImageUrl, startTime;

  Match({
    this.bestOf,
    this.timeRemaining,
    this.orangeTeamScore,
    this.orangeTeamSetScore,
    this.blueTeamScore,
    this.blueTeamSetScore,
    this.orangeTeamImageUrl,
    this.blueTeamImageUrl,
    this.startTime,
  });
}

List<Match> getDummyActiveMatches() {
  return <Match>[
    Match(
      bestOf: 7,
      timeRemaining: '3:40',
      orangeTeamScore: 6,
      blueTeamScore: 2,
      orangeTeamSetScore: 3,
      orangeTeamImageUrl:
          "https://liquipedia.net/commons/images/thumb/d/d3/G2_Esports_2019_lightmode.png/600px-G2_Esports_2019_lightmode.png",
      blueTeamImageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/NRG_Esports_logo.svg/1200px-NRG_Esports_logo.svg.png",
      blueTeamSetScore: 1,
    ),
    Match(
      blueTeamImageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Team_Envy_logo.svg/1024px-Team_Envy_logo.svg.png",
      orangeTeamImageUrl:
          "https://assets-global.website-files.com/605e2c8c6b591c8ec12559d4/60b801d8faf4750ac09f6edd_SSG1000X1000.png",
      bestOf: 7,
      blueTeamScore: 0,
      orangeTeamScore: 5,
      blueTeamSetScore: 1,
      orangeTeamSetScore: 3,
      timeRemaining: '2:10',
    ),
    Match(
      blueTeamImageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Team_Envy_logo.svg/1024px-Team_Envy_logo.svg.png",
      orangeTeamImageUrl:
          "https://assets-global.website-files.com/605e2c8c6b591c8ec12559d4/60b801d8faf4750ac09f6edd_SSG1000X1000.png",
      bestOf: 5,
      blueTeamScore: 1,
      orangeTeamScore: 2,
      blueTeamSetScore: 0,
      orangeTeamSetScore: 1,
      timeRemaining: '1:00',
    ),
  ];
}

List<Match> getDummyScheduledMatches() {
  return <Match>[
    Match(
      startTime: "12:30",
      blueTeamImageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/NRG_Esports_logo.svg/1200px-NRG_Esports_logo.svg.png",
      orangeTeamImageUrl:
          "https://liquipedia.net/commons/images/thumb/d/d3/G2_Esports_2019_lightmode.png/600px-G2_Esports_2019_lightmode.png",
    ),
    Match(
      startTime: "1:30",
      blueTeamImageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Team_Envy_logo.svg/1024px-Team_Envy_logo.svg.png",
      orangeTeamImageUrl:
          "https://assets-global.website-files.com/605e2c8c6b591c8ec12559d4/60b801d8faf4750ac09f6edd_SSG1000X1000.png",
    ),
  ];
}
