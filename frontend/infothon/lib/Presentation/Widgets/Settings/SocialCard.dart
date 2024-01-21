import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({super.key, required this.name, required this.icon});
  final String name;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 253, 253, 208),
      elevation:0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
        child: Row(
          children: [
            FaIcon(
             icon,
              size: 23,
            ),
            const SizedBox(
              width: 9,
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
