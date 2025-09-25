class Profile {
  final int id;
  final String username;
  final String fullName;
  final String profileImageUrl;
  final int postCount;
  final int followersCount;
  final int followingCount;
  final String bio;
  final String profileNote;

  Profile({
    required this.id,
    required this.username,
    required this.fullName,
    required this.profileImageUrl,
    required this.postCount,
    required this.followersCount,
    required this.followingCount,
    required this.bio,
    required this.profileNote,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      username: json['username'],
      fullName: json['fullName'],
      profileImageUrl: json['profileImageUrl'],
      postCount: json['postCount'],
      followersCount: json['followersCount'],
      followingCount: json['followingCount'],
      bio: json['bio'],
      profileNote: json['profileNote'],
    );
  }
}
