import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/ui/helpers/responsive_service.dart';
import '../../../logic/profile/profile_bloc.dart';
import '../../../logic/profile/profile_event.dart';
import '../../../logic/profile/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  final int profileId;
  final  ResponsiveService resp = ResponsiveService();

  ProfileScreen({super.key, required this.profileId});

  @override
  Widget build(BuildContext context) {
    // Ekran açıldığında profili yükle
    context.read<ProfileBloc>().add(LoadProfile(profileId));

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileError) {
            return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
          } else if (state is ProfileLoaded) {
            final p = state.profile;
            return _buildProfileView(p);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildProfileView(profile) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 🔹 AppBar
          AppBar(
            backgroundColor: Colors.black,
            titleSpacing: 0,
            title: Row(
              children: [
                const Icon(Icons.lock, color: Colors.white),
                const SizedBox(width: 8),
                Text(profile.username, style: const TextStyle(color: Colors.white)),
                const Icon(Icons.keyboard_arrow_down, color: Colors.white),
              ],
            ),
            actions: const [
              Icon(Icons.add_box_outlined, color: Colors.white),
              SizedBox(width: 16),
              Icon(Icons.menu, color: Colors.white),
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
                    )
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
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                    onPressed: () {},
                    child: const Text("Profili Düzenle", style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Profili Paylaş", style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {},
                  child: const Icon(Icons.person_add, color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCountColumn(int count, String label) {
    return Column(
      children: [
        Text("$count", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}
