
class Post {
  final String profileName;
  final String postDetail;
  final List<String> images;
  final String timeAgo;
  final int likeCount;
  final int commentCount;
  final int repostCount;

  Post({
    required this.profileName,
    required this.postDetail,
    required this.images,
    required this.timeAgo,
    this.likeCount = 0,
    this.commentCount = 0,
    this.repostCount = 0,
  });
}
