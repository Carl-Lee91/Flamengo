import 'package:flamengo/screens/dashboard/dashboard.dart';
import 'package:flamengo/screens/information/travel_information_screen.dart';
import 'package:flamengo/common/widgets/main_navigation/widget/main_appbar.dart';
import 'package:flamengo/screens/recommend/local_recommend.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MainNavigationScreen extends StatefulWidget {
  static const routeName = "mainNavigation";

  final String tab;

  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "dashboard",
    "information",
    "recommend",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const DashBoardScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const TravelInformationScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const LocalRecommendScreen(),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        backgroundColor: Theme.of(context).primaryColor,
        indicatorColor: Colors.transparent,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTap,
        destinations: const [
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.circleInfo,
            ),
            label: 'Information',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.solidStar,
            ),
            label: 'Recommend',
          ),
        ],
      ),
    );
  }
}
