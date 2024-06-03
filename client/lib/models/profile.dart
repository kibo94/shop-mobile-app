class Profile {
  final String name;

  Profile({
    required this.name,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(name: json['name']);
  }
}
