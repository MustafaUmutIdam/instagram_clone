// logic/mypost/my_post_event.dart
import 'package:equatable/equatable.dart';

abstract class MyPostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMyPosts extends MyPostEvent {
  final int profileId;
  LoadMyPosts(this.profileId);

  @override
  List<Object?> get props => [profileId];
}
