import 'package:flutter/material.dart';

class TaskColumn extends StatelessWidget {
  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String subtitle;
  TaskColumn({
    required this.icon,
    required this.iconBackgroundColor,
    required this.title,
    required this.subtitle,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 20.0,
              backgroundColor: iconBackgroundColor,
              child: Icon(
                icon,
                size: 15.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black45),
                ),
              ],
            ),
          ],
        ),
            const SizedBox(
              height: 15.0,
            ),
      ],
    );
  }
}
