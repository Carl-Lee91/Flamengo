import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flamengo/api/model/place_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecommendRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> likeStore(String placeId, String uid, PlaceModel place) async {
    final query = _db
        .collection("users")
        .doc(uid)
        .collection("likes")
        .doc("${placeId}000$uid");
    final like = await query.get();

    if (!like.exists) {
      await query.set(
        {
          "createdAt": DateTime.now().millisecondsSinceEpoch,
          "address": place.address,
          "businessStatus": place.businessStatus,
          "creatorUid": uid,
          "name": place.name,
          "placeId": placeId,
          "priceLevel": place.priceLevel,
          "rating": place.rating,
        },
      );
    } else {
      await query.delete();
    }
  }

  Future<bool> onTapLikedStore(String placeId, String uid) async {
    final query = _db
        .collection("users")
        .doc(uid)
        .collection("likes")
        .doc("${placeId}000$uid");
    final like = await query.get();
    return like.exists ? true : false;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getRecommendData(String uid) {
    final query = _db.collection("users").doc(uid).collection("likes");
    return query.get();
  }
}

final recommendRepo = Provider((ref) => RecommendRepository());
