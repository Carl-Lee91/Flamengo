import 'dart:async';

import 'package:flamengo/api/model/place_model.dart';
import 'package:flamengo/screens/authentication/repos/authentication_repo.dart';
import 'package:flamengo/screens/recommend/repos/recommend_repos.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecommendViewModels extends AsyncNotifier<void> {
  late final RecommendRepository _recommendRepo;

  @override
  FutureOr<void> build() {
    _recommendRepo = ref.read(recommendRepo);
  }

  Future<void> likeStore(PlaceModel place) async {
    state = const AsyncValue.loading();
    final user = ref.read(authRepo).user;
    state = await AsyncValue.guard(
      () async {
        await _recommendRepo.likeStore(place.placeId, user!.uid, place);
      },
    );
  }
}

final recommendProvider = AsyncNotifierProvider<RecommendViewModels, void>(
  () => RecommendViewModels(),
);
