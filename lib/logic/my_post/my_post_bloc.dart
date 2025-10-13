// logic/mypost/my_post_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/data/repositories/repository.dart';
import 'package:instagram_clone/logic/my_post/my_post_event.dart';
import 'package:instagram_clone/logic/my_post/my_post_state.dart';

class MyPostBloc extends Bloc<MyPostEvent, MyPostState> {
  final Repository repository;

  MyPostBloc(this.repository) : super(MyPostInitial()) {
    on<LoadMyPosts>(_onLoadMyPosts);
  }

  Future<void> _onLoadMyPosts(LoadMyPosts event, Emitter<MyPostState> emit) async {
    emit(MyPostLoading());
    try {
      final posts = await repository.getPostsByProfileId(event.profileId);
      emit(MyPostLoaded(posts));
    } catch (e) {
      emit(MyPostError(e.toString()));
    }
  }
}
