import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flamengo/screens/users/models/users_profile_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createProfile(UsersProfileModel profile) async {
    await _db.collection("users").doc(profile.uid).set(profile.toJson());
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }
}

final userRepo = Provider((ref) => UsersRepository());
