import 'package:flutter/material.dart';
import 'package:instagram_clone/ui/helpers/responsive_service.dart';
import 'package:instagram_clone/ui/screens/feed_screen.dart';
import 'package:instagram_clone/ui/screens/post_screen.dart';
import 'package:instagram_clone/ui/screens/profile_screen.dart';
import 'package:instagram_clone/ui/screens/reels_screen.dart';
import 'package:instagram_clone/ui/screens/search_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const FeedScreen(),
      const SearchScreen(),
      const PostScreen(),
      const ReelsScreen(),
      ProfileScreen(profileId: 1),
    ];
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ResponsiveService'i context ile initialize et
    final resp = ResponsiveService()..init(context);

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: onItemTapped,
        backgroundColor: Colors.black,
        indicatorColor: Colors.cyan.withOpacity(0.2),
        surfaceTintColor: Colors.transparent,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined,
                color: Colors.white, size: resp.width(0.07)),
            selectedIcon: Icon(Icons.home,
                color: Colors.cyan, size: resp.width(0.07)),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.search,
                color: Colors.white, size: resp.width(0.07)),
            selectedIcon: Icon(Icons.search,
                color: Colors.cyan, size: resp.width(0.07)),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_box_outlined,
                color: Colors.white, size: resp.width(0.07)),
            selectedIcon: Icon(Icons.add_box,
                color: Colors.cyan, size: resp.width(0.07)),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.slow_motion_video_rounded,
                color: Colors.white, size: resp.width(0.07)),
            selectedIcon: Icon(Icons.slow_motion_video,
                color: Colors.cyan, size: resp.width(0.07)),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded,
                color: Colors.white, size: resp.width(0.07)),
            selectedIcon: Icon(Icons.person,
                color: Colors.cyan, size: resp.width(0.07)),
            label: '',
          ),
        ],
      ),
    );
  }
}
