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

  // JSON'dan Post objesi oluştur
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      profileName: json['profileName'] ?? '',
      postDetail: json['postDetail'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      timeAgo: json['timeAgo'] ?? '',
      likeCount: json['likeCount'] ?? 0,
      commentCount: json['commentCount'] ?? 0,
      repostCount: json['repostCount'] ?? 0,
    );
  }

  // Post objesini JSON'a çevir
  Map<String, dynamic> toJson() {
    return {
      'profileName': profileName,
      'postDetail': postDetail,
      'images': images,
      'timeAgo': timeAgo,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'repostCount': repostCount,
    };
  }
}