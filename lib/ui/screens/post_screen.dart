import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/data/models/profile.dart';
import 'package:instagram_clone/logic/post/post_bloc.dart';
import 'package:instagram_clone/logic/post/post_event.dart';
import 'package:instagram_clone/logic/post/post_state.dart';
import 'package:instagram_clone/ui/helpers/responsive_service.dart';
import 'package:instagram_clone/ui/screens/home_page.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _detailCtrl = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final List<File> _pickedFiles = [];
  int _currentImageIndex = 0;

  late final ResponsiveService resp;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resp = ResponsiveService()..init(context);
    // profil yükle (id=1)
    context.read<PostBloc>().add(LoadProfileForPost(1));
  }

  Future<void> _pickImages() async {
    // Allow multiple selection up to 3 by repeated picking
    final List<XFile>? images = await _picker.pickMultiImage(imageQuality: 80);
    if (images == null || images.isEmpty) return;

    // limit to 3
    final selected = images.take(3).map((x) => File(x.path)).toList();

    setState(() {
      _pickedFiles.clear();
      _pickedFiles.addAll(selected);
      _currentImageIndex = 0;
    });
  }

  Widget _buildTopCarousel() {
    if (_pickedFiles.isEmpty) {
      return GestureDetector(
        onTap: _pickImages,
        child: Container(
          height: resp.height(0.35),
          color: Colors.grey[900],
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image_outlined, size: resp.width(0.12), color: Colors.white30),
              const SizedBox(height: 8),
              Text("Fotoğraf seç (en fazla 3)", style: TextStyle(color: Colors.white54, fontSize: resp.fontSize(0.04))),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: resp.height(0.35),
      child: Stack(
        children: [
          PageView.builder(
            itemCount: _pickedFiles.length,
            onPageChanged: (i) => setState(() => _currentImageIndex = i),
            itemBuilder: (context, index) {
              return Image.file(_pickedFiles[index], fit: BoxFit.cover, width: double.infinity);
            },
          ),
          // indicator and remove button
          Positioned(
            right: 8,
            top: 8,
            child: Row(
              children: [
                if (_pickedFiles.isNotEmpty)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _pickedFiles.removeAt(_currentImageIndex);
                        if (_currentImageIndex >= _pickedFiles.length) _currentImageIndex = _pickedFiles.length - 1;
                      });
                    },
                    icon: const Icon(Icons.delete_outline, color: Colors.white),
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pickedFiles.length, (i) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentImageIndex == i ? 10 : 6,
                  height: _currentImageIndex == i ? 10 : 6,
                  decoration: BoxDecoration(
                    color: _currentImageIndex == i ? Colors.cyan : Colors.white30,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  void _onSave(Profile profile) {
    if (_pickedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('En az 1 fotoğraf seçmelisiniz')));
      return;
    }

    final text = _detailCtrl.text.trim();
    // tetikle bloc event
    context.read<PostBloc>().add(UploadImagesAndCreatePost(
      images: List<File>.from(_pickedFiles),
      postDetail: text,
      profileId: profile.id,
      profileName: profile.username,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Yeni Gönderi'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: _pickImages,
            icon: const Icon(Icons.photo_library_outlined),
          )
        ],
      ),
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostCreated) {
            // başarılı -> geri dön veya toast
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gönderi oluşturuldu')));
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
                  (route) => false, // tüm önceki sayfaları kaldır
            );
          } else if (state is PostError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is PostLoadingProfile) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostProfileLoaded) {
            final profile = state.profile;
            return _buildForm(profile, state);
          } else if (state is PostUploadingImages || state is PostCreating) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostError) {
            return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
          }

          // initial fallback: try to render but maybe profile not loaded yet
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildForm(Profile profile, PostState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTopCarousel(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _detailCtrl,
              maxLines: 5,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Bir açıklama yaz...",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _onSave(profile),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Kaydet', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
