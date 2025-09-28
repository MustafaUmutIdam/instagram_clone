import 'package:equatable/equatable.dart';
import 'package:instagram_clone/data/models/profile.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {
  final int id;
  LoadProfile(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateProfile extends ProfileEvent {
  final Profile profile;
  UpdateProfile(this.profile);

  @override
  List<Object?> get props => [profile];
}
