import 'package:flutter/material.dart';
import 'package:instagram_clone/ui/widgets/feed_post_widget.dart';
import 'package:instagram_clone/ui/widgets/story_bar_widget.dart';
import 'package:instagram_clone/viewmodels/feed_viewmodel.dart';
import '../helpers/responsive_service.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final FeedViewModel feedVM = FeedViewModel(); // ViewModel

  @override
  void initState() {
    super.initState();
    feedVM.loadPosts(); // dummy / ram veri
    feedVM.loadStories();
  }
  final ResponsiveService resp = ResponsiveService();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Instagram",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontFamily: "cursive",
            fontSize: resp.fontSize(0.09),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.white,size: resp.width(0.08) ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.messenger_outline_rounded, color: Colors.white,size: resp.width(0.08)),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          // Hikayeler kısmı
          StoryBar(stories: feedVM.stories),

          // Gönderiler
          ...feedVM.posts.map((post) => FeedPost(
            profileName: post.profileName,
            postDetail: post.postDetail,
            images: post.images,
            timeAgo: post.timeAgo,
            likeCount: post.likeCount,
            commentCount: post.commentCount,
            repostCount: post.repostCount,
          )),
        ],
      ),
    );
  }
}
