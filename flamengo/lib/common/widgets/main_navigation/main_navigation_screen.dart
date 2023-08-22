import 'package:flamengo/screens/dashboard/dashboard_tab.dart';
import 'package:flamengo/screens/information/travel_information_screen.dart';
import 'package:flamengo/common/widgets/main_navigation/widget/main_appbar.dart';
import 'package:flamengo/screens/recommend/local_recommend.dart';
import 'package:flamengo/screens/schedule/travel_schedule.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({
    super.key,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  void _onTap(int index) {
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
            child: const DashBoardScreen(
              username: "carl",
            ),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const TravelInformationScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const LocalRecommendScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const TravelScheduleScreen(),
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
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.mapLocationDot,
            ),
            label: 'Schedule',
          ),
        ],
      ),
    );
  }
}
