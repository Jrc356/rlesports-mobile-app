class Player {
  final String? team, irlName, imageUrl;
  final String name, nationality;

  const Player({
    required this.name,
    this.irlName,
    this.team,
    this.imageUrl,
    required this.nationality,
  });

  Map<String, String> getDetails() {
    // TODO: I don't like this
    return {
      "Name": irlName ?? "",
      "Nationality": nationality,
      "Team": team ?? "",
    };
  }
}
