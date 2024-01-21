import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationCard extends StatelessWidget {
  final String name;
  final String phone;
  final String url;
final String image;
  LocationCard({
    required this.name,
    required this.phone,
    required this.url, required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: ()async {
         if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
              child: Image.network(
                image, // Add your image URL here
                height: 150.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,fontFamily: 'NotoSansKannada'
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Phone: $phone',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                // Handle URL click if needed
                print('URL clicked!');
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'View on Google Maps',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}