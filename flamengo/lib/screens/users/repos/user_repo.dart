import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flamengo/screens/users/models/users_profile_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createProfile(UserProfileModel user) async {}
}

final userRepo = Provider((ref) => UserRepository());
