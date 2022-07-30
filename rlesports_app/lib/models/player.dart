class Player {
  final String? team, irlName, imageUrl;
  bool isCoach = false;
  final String name, nationality;

  Player({
    required this.name,
    this.irlName,
    this.team,
    this.imageUrl,
    this.isCoach = false,
    required this.nationality,
  });

  Map<String, String> getDetails() {
    Map<String, String> details = {};
    details["Name"] = irlName == "null" ? "Unknown" : irlName ?? "";
    details["Nationality"] =
        nationality == "null" ? "Unknown" : nationality.toUpperCase();
    details["Team"] = team == "null" ? "Unknown" : team ?? "None";
    details["Position"] = isCoach ? "Coach" : "Player";
    return details;
  }
}
