import 'package:flamengo/features/profile/domain/entities/user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile?> getProfile(String uid);
  Future<void> createProfile(UserProfile profile);
  Future<void> updateProfile(String uid, Map<String, dynamic> updates);
}
