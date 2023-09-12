import 'package:flamengo/screens/recommend/models/place_list_models.dart';
import 'package:flamengo/screens/recommend/repos/recommend_repos.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class RecommendListViewModel extends AsyncNotifier<List<PlaceListModel>> {
  late final RecommendRepository _recommendRepo;
  List<PlaceListModel> _list = [];

  Future<List<PlaceListModel>> getRecommendData() {
    return _recommendRepo.getRecommendData();
  }

  @override
  FutureOr<List<PlaceListModel>> build() async {
    _recommendRepo = ref.read(recommendRepo);
    _list = await getRecommendData();
    state = AsyncValue.data(_list);
    return _list;
  }
}

final recommendListProvider =
    AsyncNotifierProvider<RecommendListViewModel, List<PlaceListModel>>(
  () => RecommendListViewModel(),
);
