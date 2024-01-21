import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HolidayCard extends StatefulWidget {
  const HolidayCard(
      {super.key,
      required this.description,
      required this.date,
      required this.title,
      required this.image});
  final String description;
  final String date;
  final String title;
  final String image;
  @override
  State<HolidayCard> createState() => _HolidayCardState();
}

class _HolidayCardState extends State<HolidayCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child:  CachedNetworkImage(
                      imageUrl:widget.image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      ),
                    // ),
                  ),
                  Container(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(height: 5),
                        Text(widget.title,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Container(height: 5),
                        Text(widget.date,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Container(height: 10),
                        Text(
                          widget.description,
                          maxLines: 3,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
