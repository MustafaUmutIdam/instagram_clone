import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/data/models/profile.dart';
import 'package:instagram_clone/logic/my_post/my_post_bloc.dart';
import 'package:instagram_clone/logic/my_post/my_post_event.dart';
import 'package:instagram_clone/logic/my_post/my_post_state.dart';
import 'package:instagram_clone/ui/helpers/responsive_service.dart';
import 'package:instagram_clone/ui/screens/edit_profile_screen.dart';
import '../../../logic/profile/profile_bloc.dart';
import '../../../logic/profile/profile_event.dart';
import '../../../logic/profile/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  final int profileId;
  final ResponsiveService resp = ResponsiveService();

  ProfileScreen({super.key, required this.profileId});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(LoadProfile(profileId));

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileError) {
            return Center(
              child: Text(state.message, style: const TextStyle(color: Colors.red)),
            );
          } else if (state is ProfileLoaded) {
            final p = state.profile;
            return _buildProfileView(context, p);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildProfileView(BuildContext context, Profile profile) {
    return DefaultTabController(
      length: 2,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 AppBar
            AppBar(
              backgroundColor: Colors.black,
              titleSpacing: 0,
              title: Row(
                children: [
                  const Icon(Icons.lock_outline_rounded, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(profile.username, style: const TextStyle(color: Colors.white)),
                  const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                ],
              ),
              actions: const [
                Icon(Icons.add_box_outlined, color: Colors.white),
                SizedBox(width: 16),
                Icon(Icons.menu_outlined, color: Colors.white),
                SizedBox(width: 8),
              ],
            ),

            // 🔹 Profil resmi ve sayılar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: resp.width(0.12),
                        backgroundImage: NetworkImage(profile.profileImageUrl),
                      ),
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.add, size: 16, color: Colors.white),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.grey[850],
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              profile.profileNote,
                              style: const TextStyle(color: Colors.grey, fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCountColumn(profile.postCount, "Gönderi"),
                        _buildCountColumn(profile.followersCount, "Takipçi"),
                        _buildCountColumn(profile.followingCount, "Takip"),
                      ],
                    ),
                  )
                ],
              ),
            ),

            // 🔹 İsim ve bio
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profile.fullName,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(profile.bio, style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 Butonlar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: context.read<ProfileBloc>(),
                              child: EditProfileScreen(profile: profile),
                            ),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.grey[850],
                        side: const BorderSide(color: Colors.transparent),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text("Profili Düzenle",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.grey[850],
                        side: const BorderSide(color: Colors.transparent),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text("Profili Paylaş",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.grey[850],
                      side: const BorderSide(color: Colors.transparent),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Icon(Icons.person_add_alt_1_outlined,
                        color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 Sekmeler
            const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(icon: Icon(Icons.grid_on, color: Colors.white)),
                Tab(icon: Icon(Icons.person_pin_outlined, color: Colors.white)),
              ],
            ),

            // 🔹 Sekme içerikleri
            SizedBox(
              height: 400, // GridView yüksekliği
              child: TabBarView(
                children: [
                  _buildMyPostsGrid(context, profile.id),
                  const Center(
                      child: Text("Henüz içerik yok",
                          style: TextStyle(color: Colors.white70))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountColumn(int count, String label) {
    return Column(
      children: [
        Text("$count",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget _buildMyPostsGrid(BuildContext context, int profileId) {
    // MyPostsBloc’tan veri çekelim
    context.read<MyPostBloc>().add(LoadMyPosts(profileId));
    return BlocBuilder<MyPostBloc, MyPostState>(
      builder: (context, state) {
        if (state is MyPostLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MyPostError) {
          return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
        } else if (state is MyPostLoaded) {
          final posts = state.posts;
          return GridView.builder(
            padding: const EdgeInsets.all(2),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              childAspectRatio: 1,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Image.network(
                post.images.isNotEmpty ? post.images.first : "",
                fit: BoxFit.cover,
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
