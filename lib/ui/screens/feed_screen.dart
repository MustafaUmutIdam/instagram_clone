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
  final FeedViewModel feedVM = FeedViewModel();
  final ResponsiveService resp = ResponsiveService();

  @override
  void initState() {
    super.initState();

    // ViewModel'deki değişiklikleri dinle
    feedVM.addListener(_onViewModelChanged);

    // Verileri yükle
    _loadData();
  }

  @override
  void dispose() {
    feedVM.removeListener(_onViewModelChanged);
    feedVM.dispose();
    super.dispose();
  }

  void _onViewModelChanged() {
    // ViewModel değiştiğinde setState çağır
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _loadData() async {
    await feedVM.loadAllData();
  }

  Future<void> _onRefresh() async {
    await feedVM.refreshPosts();
  }

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
            icon: Icon(Icons.favorite_border, color: Colors.white, size: resp.width(0.08)),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.messenger_outline_rounded, color: Colors.white, size: resp.width(0.08)),
            onPressed: () {},
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // Hata durumu
    if (feedVM.error != null) {
      return _buildErrorWidget();
    }

    // İlk yükleme durumu
    if (feedVM.isLoading && feedVM.posts.isEmpty) {
      return _buildLoadingWidget();
    }

    // Normal durum - veriler yüklü
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView(
        children: [
          // Hikayeler kısmı
          StoryBar(stories: feedVM.stories),

          // Loading indicator (refresh sırasında)
          if (feedVM.isLoading)
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),

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

  Widget _buildLoadingWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Gönderiler yükleniyor...',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            feedVM.error!,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadData,
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }
}