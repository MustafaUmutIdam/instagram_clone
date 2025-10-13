class MyPost {
  final int? id;
  final int profileId;
  final String profileName;
  final String postDetail;
  final List<String> images;
  final String timeAgo;
  final int likeCount;
  final int commentCount;
  final int repostCount;

  MyPost({
    this.id,
    required this.profileId,
    required this.profileName,
    required this.postDetail,
    required this.images,
    this.timeAgo = '',
    this.likeCount = 0,
    this.commentCount = 0,
    this.repostCount = 0,
  });

  factory MyPost.fromJson(Map<String, dynamic> json) {
    return MyPost(
      id: json['id'],
      profileId: json['profileId'],
      profileName: json['profileName'],
      postDetail: json['postDetail'],
      images: List<String>.from(json['images'] ?? []),
      timeAgo: json['timeAgo'] ?? '',
      likeCount: json['likeCount'] ?? 0,
      commentCount: json['commentCount'] ?? 0,
      repostCount: json['repostCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'profileId': profileId,
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
