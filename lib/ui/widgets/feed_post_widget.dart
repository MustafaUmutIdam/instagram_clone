import 'package:flutter/material.dart';
import '../helpers/responsive_service.dart';

class FeedPost extends StatefulWidget {
  const FeedPost({super.key, required this.images, required this.profileName, required this.postDetail, required this.timeAgo, this.likeCount = 0, this.commentCount = 0, this.repostCount = 0});

  final List<String> images;
  final String profileName;
  final String postDetail;
  final String timeAgo;
  final int likeCount;
  final int commentCount;
  final int repostCount;

  @override
  State<FeedPost> createState() => _FeedPostState();
}

class _FeedPostState extends State<FeedPost> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final ResponsiveService resp = ResponsiveService();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Header
          PostHeader(
            profileName: widget.profileName,
            imageRadius: resp.width(0.05),
          ),
          const SizedBox(height: 4),
          // 🔹 Images
          PostImages(
            images: widget.images,
            pageController: _pageController,
            currentPage: _currentPage,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
          const SizedBox(height: 4),
          // 🔹 Interaction bar + post detail + time
          PostInteractions(
            profileName: widget.profileName,
            postDetail: widget.postDetail,
            timeAgo: widget.timeAgo,
            likeCount: widget.likeCount,
            commentCount: widget.commentCount,
            repostCount: widget.repostCount,
          ),
        ],
      ),
    );
  }
}

// ==================== PostHeader ====================
class PostHeader extends StatelessWidget {
  const PostHeader({super.key, required this.profileName, required this.imageRadius});

  final String profileName;
  final double imageRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: imageRadius * 0.5, vertical: imageRadius * 0.2),
      child: Row(
        children: [
          CircleAvatar(
            radius: imageRadius,
            backgroundImage: NetworkImage('https://picsum.photos/50/50?random=4'),
          ),
          SizedBox(width: imageRadius * 0.5),
          Expanded(
            child: Text(
              profileName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: imageRadius * 0.8,color: Colors.white),
            ),
          ),
          IconButton(
            icon: Icon(Icons.more_vert_rounded, size: imageRadius * 1.1,color: Colors.white,),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// ==================== PostImages ====================
class PostImages extends StatelessWidget {
  PostImages({super.key, required this.images, required this.pageController, required this.currentPage, required this.onPageChanged});

  final List<String> images;
  final PageController pageController;
  final int currentPage;
  final Function(int) onPageChanged;

  final ResponsiveService resp = ResponsiveService();

  @override
  Widget build(BuildContext context) {
    double screenWidth = resp.screenWidth;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: screenWidth,
          child: PageView.builder(
            controller: pageController,
            itemCount: images.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              return Image.network(
                images[index],
                fit: BoxFit.cover,
                width: double.infinity,
              );
            },
          ),
        ),
        if (images.length > 1)
          Positioned(
            bottom: resp.height(0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                    (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: resp.width(0.01)),
                  width: currentPage == index ? resp.width(0.02) : resp.width(0.015),
                  height: currentPage == index ? resp.width(0.02) : resp.width(0.015),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage == index ? Colors.cyanAccent : Colors.white70,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ==================== PostInteractions ====================
class PostInteractions extends StatelessWidget {
  PostInteractions({
    super.key,
    required this.profileName,
    required this.postDetail,
    required this.timeAgo,
    required this.likeCount,
    required this.commentCount,
    required this.repostCount,
  });

  final String profileName;
  final String postDetail;
  final String timeAgo;
  final int likeCount;
  final int commentCount;
  final int repostCount;

  final ResponsiveService resp = ResponsiveService();

  @override
  Widget build(BuildContext context) {
    double iconSize = resp.width(0.07);
    double spacing = resp.width(0.04);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Interaction icons
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.favorite_border, size: iconSize,color: Colors.white,),
                  SizedBox(width: spacing / 2),
                  Text('$likeCount', style: TextStyle(fontSize: iconSize * 0.6,color: Colors.white,)),
                  SizedBox(width: spacing),
                  Icon(Icons.mode_comment_outlined, size: iconSize,color: Colors.white),
                  SizedBox(width: spacing / 2),
                  Text('$commentCount', style: TextStyle(fontSize: iconSize * 0.6,color: Colors.white)),
                  SizedBox(width: spacing),
                  Icon(Icons.repeat_rounded, size: iconSize,color: Colors.white),
                  SizedBox(width: spacing / 2),
                  Text('$repostCount', style: TextStyle(fontSize: iconSize * 0.6,color: Colors.white)),
                  SizedBox(width: spacing),
                  Icon(Icons.send_rounded, size: iconSize,color: Colors.white),
                ],
              ),
              const Spacer(),
              Icon(Icons.bookmark_border, size: iconSize,color: Colors.white),
            ],
          ),
          SizedBox(height: spacing / 2),
          // 🔹 Post text
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.white, fontSize: iconSize * 0.52),
              children: [
                TextSpan(text: '$profileName ', style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: postDetail),
              ],
            ),
          ),
          SizedBox(height: spacing / 2),
          // 🔹 Time ago
          Text(
            timeAgo,
            style: TextStyle(color: Colors.white54, fontSize: iconSize * 0.5),
          ),
          SizedBox(height: spacing / 2,)
        ],
      ),
    );
  }
}
