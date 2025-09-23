class Story {
  final int id;
  final String profileName;
  final String profileImageUrl;
  final bool isMine;
  final bool hasStory;

  Story({
    required this.id,
    required this.profileName,
    required this.profileImageUrl,
    this.isMine = false,
    this.hasStory = true,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'] as int,
      profileName: json['profileName'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
      isMine: json['isMine'] ?? false,
      hasStory: json['hasStory'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profileName': profileName,
      'profileImageUrl': profileImageUrl,
      'isMine': isMine,
      'hasStory': hasStory,
    };
  }
}
