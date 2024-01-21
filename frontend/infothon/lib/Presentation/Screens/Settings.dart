import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Widgets/Settings/SocialCard.dart';
import '../utils/constants.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String selectedOption = 'Choose language';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: const Color(0xF5C400),
      ),
      backgroundColor: const Color.fromARGB(255, 253, 253, 208),
      body: ListView(

        children: [
          DropdownButton<String>(
            icon: FaIcon(FontAwesomeIcons.language),
            value: selectedOption,
            items: [
              DropdownMenuItem(
                value: 'Choose language',
                child: Text('Choose language'),
              ),
              DropdownMenuItem(
                value: 'Option 1',
                child: Text('Option 1'),
              ),
              DropdownMenuItem(
                value: 'Option 2',
                child: Text('Option 2'),
              ),
              DropdownMenuItem(
                value: 'Option 3',
                child: Text('Option 3'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                selectedOption = value!;
              });
            },
          ),
          GestureDetector(
            onTap: () async {},
            child: const SocialCard(
              name: 'Switch language',
              icon: FontAwesomeIcons.language,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/becomeastudent');
            },
            child: const SocialCard(
              name: 'Become a Student',
              icon: FontAwesomeIcons.rightToBracket,
            ),
          ),
        ],
      ),
    );
  }
}
