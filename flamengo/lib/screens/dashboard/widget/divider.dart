import 'package:flamengo/constants/sizes.dart';
import 'package:flutter/material.dart';

class DashboardDivider extends StatelessWidget {
  const DashboardDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: Sizes.size1,
      color: Colors.grey.shade400,
    );
  }
}
