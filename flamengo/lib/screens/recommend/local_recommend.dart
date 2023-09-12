import 'package:flamengo/constants/sizes.dart';
import 'package:flamengo/screens/recommend/view_models/recommend_list_view_model.dart';
import 'package:flamengo/screens/recommend/widgets/place_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalRecommendScreen extends ConsumerStatefulWidget {
  const LocalRecommendScreen({super.key});

  @override
  ConsumerState<LocalRecommendScreen> createState() =>
      LocalRecommendScreenState();
}

class LocalRecommendScreenState extends ConsumerState<LocalRecommendScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _onRefresh() {
    return ref.watch(recommendListProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(recommendListProvider).when(
          data: (place) {
            final placeList = place;
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: placeList.length,
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size10,
                  horizontal: Sizes.size20,
                ),
                itemBuilder: (context, index) {
                  var place = placeList[index];
                  return Container(
                    margin: const EdgeInsets.only(
                      bottom: Sizes.size10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: Sizes.size1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          offset: const Offset(5, 5),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PlaceText(
                            place: place,
                            text: place.name,
                          ),
                          PlaceText(
                            place: place,
                            text: place.businessStatus,
                          ),
                          PlaceText(
                            place: place,
                            text: place.address,
                          ),
                          PlaceText(
                            place: place,
                            text: "Rating: ${place.rating}",
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  width: Sizes.size40,
                ),
              ),
            );
          },
          error: (error, stackTrace) => Center(
            child: Text(
              "Please Setting Your Favorite Store!",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
