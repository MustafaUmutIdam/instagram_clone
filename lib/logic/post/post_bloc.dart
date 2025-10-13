import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/data/models/mypost.dart';
import 'package:instagram_clone/data/models/profile.dart';
import 'package:instagram_clone/data/repositories/repository.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final Repository repository;

  PostBloc(this.repository) : super(PostInitial()) {
    on<LoadProfileForPost>(_onLoadProfile);
    on<UploadImagesAndCreatePost>(_onUploadAndCreate);
  }

  Future<void> _onLoadProfile(LoadProfileForPost event, Emitter<PostState> emit) async {
    emit(PostLoadingProfile());
    try {
      final Profile profile = await repository.fetchProfile(event.profileId);
      emit(PostProfileLoaded(profile));
    } catch (e) {
      emit(PostError('Profil yüklenemedi: $e'));
    }
  }

  Future<void> _onUploadAndCreate(UploadImagesAndCreatePost event, Emitter<PostState> emit) async {
    try {
      emit(PostUploadingImages());
      // 1) upload files
      final List<String> uploadedUrls = await repository.uploadImages(event.images);

      emit(PostCreating());
      // 2) create post body (dummy counts/time)
      final MyPost newPost = MyPost(
        profileId: event.profileId,
        profileName: event.profileName,
        postDetail: event.postDetail,
        images: uploadedUrls,
        timeAgo: 'az önce',
        likeCount: 0,
        commentCount: 0,
        repostCount: 0,
      );

      final MyPost created = await repository.createMyPost(newPost);

      emit(PostCreated(created));
    } catch (e) {
      emit(PostError('Post oluşturulurken hata: $e'));
    }
  }
}
