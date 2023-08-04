import 'package:flamengo/screens/mainnavigation/widget/main_appbar.dart';
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
  final List _tabs = [
    const Center(
      child: Text('Dashboard'),
    ),
    const Center(
      child: Text('Information'),
    ),
    const Center(
      child: Text('Recommend'),
    ),
    const Center(
      child: Text('Schedule'),
    )
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: _tabs[_selectedIndex],
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
              color: Colors.white,
            ),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.info,
              color: Colors.white,
            ),
            label: 'Information',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.checkDouble,
              color: Colors.white,
            ),
            label: 'Recommend',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.mapLocationDot,
              color: Colors.white,
            ),
            label: 'Schedule',
          ),
        ],
      ),
    );
  }
}
