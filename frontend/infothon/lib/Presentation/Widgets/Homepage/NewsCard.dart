import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsCards extends StatelessWidget {
  const NewsCards(
      {super.key, required this.title, required this.date, required this.img});
  final String title;
  final String date;
  final String img;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Adjust the elevation as needed
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              img,
              errorListener: (error) {
                print(error);
              },
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.black
                    .withOpacity(0.6), // Adjust the opacity as desired
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18, // Adjust the font size as needed
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12, // Adjust the font size as needed
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
