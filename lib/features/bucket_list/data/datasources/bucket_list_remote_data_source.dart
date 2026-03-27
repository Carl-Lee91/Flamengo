import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

import 'package:flamengo/core/firebase/realtime_db_refs.dart';

@injectable
class BucketListRemoteDataSource {
  BucketListRemoteDataSource(this._database);

  final FirebaseDatabase _database;

  Future<List<Map<String, dynamic>>> getAll(String uid) async {
    final snapshot = await _database.ref(DbRefs.bucketList(uid)).get();
    if (!snapshot.exists || snapshot.value == null) return [];

    final map = Map<String, dynamic>.from(snapshot.value as Map);
    return map.entries.map((e) {
      final data = Map<String, dynamic>.from(e.value as Map);
      data['id'] = e.key;
      return data;
    }).toList();
  }

  Future<void> addItem(String uid, String itemId, Map<String, dynamic> data) async {
    await _database.ref(DbRefs.bucketItem(uid, itemId)).set(data);
  }

  Future<void> updateItem(String uid, String itemId, Map<String, dynamic> data) async {
    await _database.ref(DbRefs.bucketItem(uid, itemId)).update(data);
  }

  Future<void> deleteItem(String uid, String itemId) async {
    await _database.ref(DbRefs.bucketItem(uid, itemId)).remove();
  }
}
