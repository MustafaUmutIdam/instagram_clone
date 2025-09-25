import 'package:equatable/equatable.dart';

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
