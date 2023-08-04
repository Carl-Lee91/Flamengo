import 'package:flamengo/constants/sizes.dart';
import 'package:flamengo/screens/setting/settings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const MainAppBar({
    super.key,
  });

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
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
      leading: const Center(
        child: FaIcon(
          FontAwesomeIcons.bars,
        ),
      ),
      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
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
