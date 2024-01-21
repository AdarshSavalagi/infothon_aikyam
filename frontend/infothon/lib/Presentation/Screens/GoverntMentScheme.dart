import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:infothon/Presentation/Widgets/Homepage/govtCard.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class GovernmentPage extends StatefulWidget {
  const GovernmentPage({super.key});

  @override
  State<GovernmentPage> createState() => _GovernmentPageState();
}

class _GovernmentPageState extends State<GovernmentPage> {
  List data = [];
  late String state;
  Future<void> getData() async {
    var url = Uri.parse('https://hackathon.aldoiris.online/api/get_data/');
    var response = await http
        .post(url, body: {'latitude': '0', 'longitude': '0', 'type': '3'});
    var prefs = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
        state = prefs.getString('state')!;
        _isMounted = true;
        print(data);
      });
    } else {
      print('error');
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getData();
    });
    super.initState();
  }

  bool _isMounted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Government Schemes'),
        ),
        body: _isMounted
            ? ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, index) {
                  if (data[index]['governtment_type'] == states[state]) {
                    return BusinessCard(
                        title: data[index]['name'],
                        subtitle: data[index]['description'],
                        eligibility: data[index]['eligibility'],
                        type: data[index]['Type']);
                  } else {
                    return Container();
                  }
                })
            : Center(child: const CircularProgressIndicator()));
  }
}
