class Team {
  final String name;
  final String imageUrl;
  final String? region;

  Team({
    required this.name,
    required this.imageUrl,
    this.region,
  });

  Map<String, String> getDetails() {
    Map<String, String> details = {};
    details["Region"] = region.toString().toUpperCase();
    return details;
  }
}
