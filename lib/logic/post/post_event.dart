import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/data/models/mypost.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProfileForPost extends PostEvent {
  final int profileId;
  LoadProfileForPost(this.profileId);

  @override
  List<Object?> get props => [profileId];
}

// UI seçilen resimleri gönderdiğinde
class UploadImagesAndCreatePost extends PostEvent {
  final List<File> images;
  final String postDetail;
  final int profileId;
  final String profileName;

  UploadImagesAndCreatePost({
    required this.images,
    required this.postDetail,
    required this.profileId,
    required this.profileName,
  });

  @override
  List<Object?> get props => [images, postDetail, profileId, profileName];
}
