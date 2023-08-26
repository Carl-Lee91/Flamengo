import 'package:flamengo/constants/gaps.dart';
import 'package:flamengo/constants/sizes.dart';
import 'package:flamengo/screens/dashboard/widget/avatar.dart';
import 'package:flamengo/screens/dashboard/widget/divider.dart';
import 'package:flamengo/screens/users/view_models/users_view_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size28,
                  vertical: Sizes.size48,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("data"),
                            Gaps.v8,
                            DashboardDivider(),
                            Gaps.v8,
                            Text("data"),
                            Gaps.v8,
                            DashboardDivider(),
                            Gaps.v8,
                            Text("data"),
                            Gaps.v8,
                            DashboardDivider(),
                            Gaps.v8,
                          ],
                        ),
                      ],
                    ),
                    Gaps.v36,
                    Text(
                      "My Travel Schedule",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: Sizes.size24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gaps.v36,
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.amber.shade200,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size12,
                            vertical: Sizes.size12,
                          ),
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text("Item $index"),
                                leading: FaIcon(
                                  FontAwesomeIcons.solidCircle,
                                  size: Sizes.size10,
                                  color: Theme.of(context).primaryColor,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const DashboardDivider(),
                            itemCount: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}
