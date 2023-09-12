import 'package:flamengo/screens/recommend/models/place_list_models.dart';
import 'package:flamengo/screens/recommend/repos/recommend_repos.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class RecommendListViewModel extends AsyncNotifier<List<PlaceListModel>> {
  late final RecommendRepository _recommendRepo;
  List<PlaceListModel> _list = [];

  Future<List<PlaceListModel>> _getRecommendData() async {
    final result = await _recommendRepo.getRecommendData();
    final places = result.docs.map(
      (doc) => PlaceListModel.fromJson(
        json: doc.data(),
      ),
    );
    return places.toList();
  }

  @override
  FutureOr<List<PlaceListModel>> build() async {
    _recommendRepo = ref.read(recommendRepo);
    _list = await _getRecommendData();
    return _list;
  }

  Future<void> refresh() async {
    final places = await _getRecommendData();
    _list = places;
    state = AsyncValue.data(places);
  }
}

final recommendListProvider =
    AsyncNotifierProvider<RecommendListViewModel, List<PlaceListModel>>(
  () => RecommendListViewModel(),
);
