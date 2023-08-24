import 'package:flamengo/constants/gaps.dart';
import 'package:flamengo/constants/sizes.dart';
import 'package:flamengo/screens/authentication/repos/authentication_repo.dart';
import 'package:flamengo/screens/setting/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MainAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const MainAppBar({
    super.key,
  });

  @override
  ConsumerState<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends ConsumerState<MainAppBar> {
  void onTapToSettingScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Flamengo"),
      leading: PopupMenuButton(
          icon: const Center(
            child: FaIcon(
              FontAwesomeIcons.bars,
            ),
          ),
          itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      foregroundImage: NetworkImage(
                          "https://lh3.googleusercontent.com/a/AGNmyxamUvm-3XN71fNXENMkFOcuBM1YTGv4RKiqqEd09g=s432-c-no"),
                      child: Text("Carl"),
                    ),
                    Gaps.v8,
                    Text(
                      "@User",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Logout"),
                    Icon(
                      Icons.logout_rounded,
                    )
                  ],
                ),
              ),
            ];
          },
          onSelected: (value) {
            if (value == 0) {
              null;
            } else if (value == 1) {
              ref.read(authRepo).signOut();
              context.go("/");
            }
          }),
      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size6,
            ),
            child: IconButton(
              onPressed: onTapToSettingScreen,
              icon: const FaIcon(
                FontAwesomeIcons.gear,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
