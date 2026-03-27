import 'package:flamengo/constants/gaps.dart';
import 'package:flamengo/constants/sizes.dart';
import 'package:flamengo/screens/dashboard/widget/avatar.dart';
import 'package:flamengo/screens/users/view_models/users_view_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  const DashBoardScreen({
    super.key,
  });

  @override
  ConsumerState<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size28,
                vertical: Sizes.size48,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Avatar(
                            name: data.name,
                            hasAvatar: data.hasAvatar,
                            uid: data.uid,
                          ),
                          Gaps.v8,
                          Text(
                            "@${data.name}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gaps.v36,
                  Text(
                    "Welcome ${data.name}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gaps.v36,
                  const Text(
                    "Enjoy Your Trip!",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    "Press information to search store",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    "Press recommend to view your favorite store",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
