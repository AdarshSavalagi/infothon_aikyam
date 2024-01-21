import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Community",
      )),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Version",
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(
                 version,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                child: Text(
                  "Srinivas Institute of Technology for Android software ©. All rights reserved. Srinivas Institute of Technology and the SIT-Mangaluru logo are trademarks of sitmng.ac.in, Inc. or its affiliates",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/privacyscreen');
                },
                child: const Text(
                  "Terms and Privacy Notice",
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                )),
          ]),
        ],
      ),
    );
  }
}
