import 'dart:async';

import 'package:flamengo/api/model/place_model.dart';
import 'package:flamengo/screens/authentication/repos/authentication_repo.dart';
import 'package:flamengo/screens/recommend/repos/recommend_repos.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecommendViewModels extends FamilyAsyncNotifier<void, String> {
  late final RecommendRepository _recommendRepo;
  late final _placeId;

  @override
  FutureOr<void> build(String placeId) {
    _recommendRepo = ref.read(recommendRepo);
    _placeId = placeId;
  }

  Future<void> likeStore(PlaceModel place) async {
    final user = ref.read(authRepo).user;
    await _recommendRepo.likeStore(_placeId, user!.uid, place);
  }
}

final recommendProvider =
    AsyncNotifierProvider.family<RecommendViewModels, void, String>(
  () => RecommendViewModels(),
);
