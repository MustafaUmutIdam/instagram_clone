class Story {
  final String profileName;
  final String profileImageUrl;
  final bool isMine;
  final bool hasStory; // çerçeve var mı yok mu

  Story({
    required this.profileName,
    required this.profileImageUrl,
    this.isMine = false,
    this.hasStory = true,
  });
}
