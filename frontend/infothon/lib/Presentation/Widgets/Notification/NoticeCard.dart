import 'package:flutter/material.dart';


class NoticeCard extends StatelessWidget {

  final String title;
  final String date;
  final String description;
  const NoticeCard(
      {Key? key,
        required this.title,
        required this.date,
        required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        elevation: 1,
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                // leading: const Icon(Icons.add_alert_outlined),
                // title: Text('title', style: TextStyle(fontSize: 18.0)),
                subtitle: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ExpansionTile(
                    trailing: const Text(""),
                    title: Text(title,
                        style:const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    subtitle: Text(date,
                        style: Theme.of(context).textTheme.bodySmall),
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            description,
                            style: const TextStyle(fontSize: 15.0),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                      
                    ],
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