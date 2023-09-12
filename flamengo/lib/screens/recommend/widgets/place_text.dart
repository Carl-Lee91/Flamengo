import 'package:flamengo/screens/recommend/models/place_list_models.dart';
import 'package:flutter/material.dart';

class PlaceText extends StatelessWidget {
  const PlaceText({
    super.key,
    required this.place,
    required this.text,
  });

  final PlaceListModel place;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w600),
    );
  }
}
