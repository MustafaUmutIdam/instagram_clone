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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'fullName': fullName,
      'profileImageUrl': profileImageUrl,
      'postCount': postCount,
      'followersCount': followersCount,
      'followingCount': followingCount,
      'bio': bio,
      'profileNote': profileNote,
    };
  }

  Profile copyWith({
    int? id,
    String? username,
    String? fullName,
    String? profileImageUrl,
    int? postCount,
    int? followersCount,
    int? followingCount,
    String? bio,
    String? profileNote,
  }) {
    return Profile(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      postCount: postCount ?? this.postCount,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      bio: bio ?? this.bio,
      profileNote: profileNote ?? this.profileNote,
    );
  }
}
