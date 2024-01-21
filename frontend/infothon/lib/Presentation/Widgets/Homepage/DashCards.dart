import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/colors.dart';

class HomeCard extends StatelessWidget {
  final Color cardColor;
  final IconData icon;
  final String title;

  const HomeCard({
    super.key,
    required this.cardColor,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(15.0),
      height: MediaQuery.of(context).size.width * 0.32,
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(6.0),
              child: FaIcon(
                icon,
                size: 30,
                color: LightColors.kDarkBlue,
              )),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13.0,
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
