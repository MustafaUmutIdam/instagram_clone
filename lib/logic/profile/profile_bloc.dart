import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/data/repositories/repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final Repository repository;

  ProfileBloc(this.repository) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await repository.fetchProfile(event.id);
        emit(ProfileLoaded(profile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<UpdateProfile>((event, emit) async {
      emit(ProfileUpdating());
      try {
        final updated = await repository.updateProfile(event.profile);
        emit(ProfileUpdated(updated));
        emit(ProfileLoaded(updated)); // tekrar ekrana yükle
      } catch (e) {
        emit(ProfileError("Profil güncellenemedi: $e"));
      }
    });
  }
}
