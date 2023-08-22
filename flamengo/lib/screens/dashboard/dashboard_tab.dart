import 'package:flamengo/constants/gaps.dart';
import 'package:flamengo/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashBoardScreen extends StatefulWidget {
  final String username;

  const DashBoardScreen({
    super.key,
    required this.username,
  });

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size28,
            vertical: Sizes.size48,
          ),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("data"),
                      Gaps.v8,
                      Divider(),
                      Gaps.v8,
                      Text("data"),
                      Gaps.v8,
                      Divider(),
                      Gaps.v8,
                      Text("data"),
                      Gaps.v8,
                      Divider(),
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
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Divider extends StatelessWidget {
  const Divider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: Sizes.size1,
      color: Colors.grey.shade400,
    );
  }
}
