import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

import 'package:flamengo/core/firebase/realtime_db_refs.dart';

@injectable
class ProfileRemoteDataSource {
  ProfileRemoteDataSource(this._database);

  final FirebaseDatabase _database;

  Future<Map<String, dynamic>?> getProfile(String uid) async {
    final snapshot = await _database.ref(DbRefs.profile(uid)).get();
    if (!snapshot.exists || snapshot.value == null) return null;
    return Map<String, dynamic>.from(snapshot.value as Map);
  }

  Future<void> createProfile(String uid, Map<String, dynamic> data) async {
    await _database.ref(DbRefs.profile(uid)).set(data);
  }

  Future<void> updateProfile(String uid, Map<String, dynamic> updates) async {
    updates['updatedAt'] = DateTime.now().millisecondsSinceEpoch;
    await _database.ref(DbRefs.profile(uid)).update(updates);
  }
}
