import 'package:flutter/material.dart';

class BusinessCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String eligibility;
  final String type;

  BusinessCard({
    required this.title,
    required this.subtitle,
    required this.eligibility,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Eligibility: $eligibility',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Type: $type',
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Business Card Example'),
//         ),
//         body: Center(
//           child: BusinessCard(
//             title: 'Example Business',
//             subtitle: '123 Main Street, Cityville',
//             eligibility: 'Open to all residents',
//             type: 'Restaurant',
//           ),
//         ),
//       ),
//     );
//   }
// }
