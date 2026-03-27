import 'package:injectable/injectable.dart';

import 'package:flamengo/features/profile/domain/entities/user_profile.dart';
import 'package:flamengo/features/profile/domain/repositories/profile_repository.dart';
import 'package:flamengo/features/profile/data/datasources/profile_remote_data_source.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._dataSource);

  final ProfileRemoteDataSource _dataSource;

  @override
  Future<UserProfile?> getProfile(String uid) async {
    final data = await _dataSource.getProfile(uid);
    if (data == null) return null;
    return UserProfile.fromJson({...data, 'uid': uid});
  }

  @override
  Future<void> createProfile(UserProfile profile) async {
    await _dataSource.createProfile(profile.uid, profile.toJson()..remove('uid'));
  }

  @override
  Future<void> updateProfile(String uid, Map<String, dynamic> updates) async {
    await _dataSource.updateProfile(uid, updates);
  }
}
