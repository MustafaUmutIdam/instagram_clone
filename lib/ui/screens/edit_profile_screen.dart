import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/data/models/profile.dart';
import 'package:instagram_clone/logic/profile/profile_bloc.dart';
import 'package:instagram_clone/logic/profile/profile_event.dart';
import 'package:instagram_clone/logic/profile/profile_state.dart';

class EditProfileScreen extends StatefulWidget {
  final Profile profile;
  const EditProfileScreen({super.key, required this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController usernameCtrl;
  late TextEditingController fullNameCtrl;
  late TextEditingController bioCtrl;
  late TextEditingController noteCtrl;
  late TextEditingController imageCtrl;

  @override
  void initState() {
    super.initState();
    usernameCtrl = TextEditingController(text: widget.profile.username);
    fullNameCtrl = TextEditingController(text: widget.profile.fullName);
    bioCtrl = TextEditingController(text: widget.profile.bio);
    noteCtrl = TextEditingController(text: widget.profile.profileNote);
    imageCtrl = TextEditingController(text: widget.profile.profileImageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Profili Düzenle"),
        backgroundColor: Colors.black,
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            Navigator.pop(context); // güncellenince geri dön
          }
        },
        builder: (context, state) {
          if (state is ProfileUpdating) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                _buildInput("Kullanıcı Adı", usernameCtrl),
                _buildInput("Ad Soyad", fullNameCtrl),
                _buildInput("Biyografi", bioCtrl),
                _buildInput("Profil Notu", noteCtrl),
                _buildInput("Profil Resmi URL", imageCtrl),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final updated = widget.profile.copyWith(
                      username: usernameCtrl.text,
                      fullName: fullNameCtrl.text,
                      bio: bioCtrl.text,
                      profileNote: noteCtrl.text,
                      profileImageUrl: imageCtrl.text,
                    );
                    context.read<ProfileBloc>().add(UpdateProfile(updated));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                  ),
                  child: const Text("Kaydet"),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController ctrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: ctrl,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan),
          ),
        ),
      ),
    );
  }
}
