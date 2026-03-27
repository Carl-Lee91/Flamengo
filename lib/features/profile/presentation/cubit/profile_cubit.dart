import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:flamengo/core/utils/logger.dart';
import 'package:flamengo/features/profile/domain/entities/user_profile.dart';
import 'package:flamengo/features/profile/domain/repositories/profile_repository.dart';
import 'package:flamengo/features/profile/presentation/cubit/profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepository) : super(const ProfileState.initial());

  final ProfileRepository _profileRepository;

  Future<void> loadProfile(String uid) async {
    emit(const ProfileState.loading());
    try {
      final profile = await _profileRepository.getProfile(uid);
      if (profile != null) {
        log.i('[Profile] loaded: ${profile.displayName}');
        emit(ProfileState.loaded(profile));
      } else {
        log.e('[Profile] not found for uid: $uid');
        emit(const ProfileState.error('Profile not found'));
      }
    } catch (e, st) {
      log.e('[Profile] loadProfile failed', error: e, stackTrace: st);
      emit(ProfileState.error(e.toString()));
    }
  }

  Future<void> createProfileIfNeeded({
    required String uid,
    required String displayName,
    required String email,
  }) async {
    try {
      final existing = await _profileRepository.getProfile(uid);
      if (existing != null) {
        log.i('[Profile] already exists: ${existing.displayName}');
        emit(ProfileState.loaded(existing));
        return;
      }

      final now = DateTime.now().millisecondsSinceEpoch;
      final profile = UserProfile(
        uid: uid,
        displayName: displayName,
        email: email,
        createdAt: now,
        updatedAt: now,
      );
      await _profileRepository.createProfile(profile);
      log.i('[Profile] created: $displayName');
      emit(ProfileState.loaded(profile));
    } catch (e, st) {
      log.e('[Profile] createProfileIfNeeded failed', error: e, stackTrace: st);
      emit(ProfileState.error(e.toString()));
    }
  }

  Future<void> updateDisplayName(String uid, String newName) async {
    try {
      await _profileRepository.updateProfile(uid, {'displayName': newName});
      log.i('[Profile] updated name: $newName');
      await loadProfile(uid);
    } catch (e, st) {
      log.e('[Profile] updateDisplayName failed', error: e, stackTrace: st);
      emit(ProfileState.error(e.toString()));
    }
  }
}
