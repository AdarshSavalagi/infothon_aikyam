import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:infothon/Presentation/Widgets/Homepage/DisplayCard.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DisplayContentPage extends StatefulWidget {
  const DisplayContentPage({super.key});

  @override
  State<DisplayContentPage> createState() => _DisplayContentPageState();
}

class _DisplayContentPageState extends State<DisplayContentPage> {
  late String param1;
  late List data = [];
  bool _isMounted = false;
  Future<void> getData() async {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    param1 = args?['keyword'] ?? '';
    var prefs = await SharedPreferences.getInstance();

    String? latitude = prefs.getString('latitude');
    String? longitude = prefs.getString('longitude');
    var response = await http.post(
  Uri.parse('https://hackathon.aldoiris.online/api/get_data/'),
  body: param1 == 'All'
      ? {'latitude': latitude, 'longitude': longitude, "lang": "kn"}
      : {
          'latitude': latitude,
          'longitude': longitude,
          'type': '1',
          "lang": "kn",
          'amenity': param1
        },
);

setState(() {
  print(param1 == 'All'
      ? {'latitude': latitude, 'longitude': longitude, "lang": "kn"}
      : {
          'latitude': latitude,
          'longitude': longitude,
          'type': '1',
          "lang": "kn",
          'amenity': param1
        });

  if (response.statusCode == 200) {
    // Decode response using UTF-8
    String responseBody = utf8.decode(response.bodyBytes);

    // Parse JSON
    data = jsonDecode(responseBody);
    print(data);
    _isMounted = true;
  } else {
    data = [];
  }
});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('data'),
        ),
        body: _isMounted
            ? ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, index) {
                  return LocationCard(
                      name: data[index]['name'],
                      phone: data[index]['phone'],
                      url: data[index]['url'],
                      image: data[index]['photo_url']);
                })
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
