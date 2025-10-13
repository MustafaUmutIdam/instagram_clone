// logic/mypost/my_post_state.dart
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/data/models/mypost.dart';

abstract class MyPostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MyPostInitial extends MyPostState {}

class MyPostLoading extends MyPostState {}

class MyPostLoaded extends MyPostState {
  final List<MyPost> posts;
  MyPostLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class MyPostError extends MyPostState {
  final String message;
  MyPostError(this.message);

  @override
  List<Object?> get props => [message];
}
