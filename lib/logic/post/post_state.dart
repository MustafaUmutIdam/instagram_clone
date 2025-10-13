import 'package:equatable/equatable.dart';
import 'package:instagram_clone/data/models/profile.dart';
import 'package:instagram_clone/data/models/mypost.dart';

abstract class PostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostInitial extends PostState {}

class PostLoadingProfile extends PostState {}

class PostProfileLoaded extends PostState {
  final Profile profile;
  PostProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class PostUploadingImages extends PostState {}

class PostCreating extends PostState {}

class PostCreated extends PostState {
  final MyPost post;
  PostCreated(this.post);

  @override
  List<Object?> get props => [post];
}

class PostError extends PostState {
  final String message;
  PostError(this.message);

  @override
  List<Object?> get props => [message];
}
