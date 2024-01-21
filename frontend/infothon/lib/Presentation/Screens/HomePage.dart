import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widgets/Homepage/DashCards.dart';
import '../Widgets/Homepage/TopContainer.dart';
import '../utils/colors.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  static CircleAvatar calendarIcon() {
    return const CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List colors = [LightColors.kBlue, LightColors.kRed, LightColors.kPalePink];

  List<Map<String, dynamic>> cards_list = [
    {'name': 'ಎಲ್ಲವೂ', 'icon': FontAwesomeIcons.globe, 'page': 'All'},
    {'name': 'ಕಾಲೇಜು', 'icon': FontAwesomeIcons.school, 'page': 'college'},
    {'name': 'ಆಸ್ಪತ್ರೆ', 'icon': FontAwesomeIcons.hospitalUser, 'page': 'hospital'},
    {'name': 'ಉಪಾಹಾರ ಗೃಹ', 'icon': FontAwesomeIcons.hotel, 'page': 'restaurants'},
    {'name': 'ಔಷಧಿ ಕೇಂದ್ರ', 'icon': FontAwesomeIcons.notesMedical, 'page': 'Pharmacy'},
    {'name': 'ಪೆಟ್ರೋಲ್ ಬಂಕ್', 'icon': FontAwesomeIcons.gasPump, 'page': 'Petrol bunk'},
    {
      'name': 'ಬ್ಯಾಂಕ್ & ಎಟಿಎಂ',
      'icon': FontAwesomeIcons.buildingColumns,
      'page':'bank and Atms'
    },
    {'name': 'ದಿನಸಿ ಅಂಗಡಿ', 'icon': FontAwesomeIcons.bagShopping, 'page': 'Grocery'},
    {'name': 'ಬಟ್ಟೆ ಅಂಗಡಿ', 'icon': FontAwesomeIcons.shop, 'page': 'clothing'},
    {'name': 'ಬೇಕರಿ', 'icon': FontAwesomeIcons.breadSlice, 'page': 'bakery'},
    {'name': 'ಜಿಮ್', 'icon': FontAwesomeIcons.dumbbell, 'page': 'gym'},
    {'name': 'ನಾಟ್ಯಮ೦ದಿರ', 'icon': FontAwesomeIcons.film, 'page': 'theatre'},
    {'name': 'ಪಾರ್ಲರ್', 'icon': FontAwesomeIcons.shop, 'page': 'beauty'},
    {'name': 'ಬಾರ್', 'icon': FontAwesomeIcons.champagneGlasses, 'page':'bar'},
  ];

  String name = '', usn = '';
  int gender = 0;

  @override
  void initState() {
    super.initState();
    () async {
      var prefs = await SharedPreferences.getInstance();
      setState(() {
        name = prefs.getString('name')!;
      });
    }();
  }

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Good morning!';
    } else if (hour >= 12 && hour < 17) {
      return 'Good afternoon!';
    } else if (hour >= 17 && hour < 21) {
      return 'Good evening!';
    } else {
      return 'Good night!';
    }
  }

  Text subheading(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 253, 208),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              height: 200,
              width: width,
              padding: const EdgeInsets.all(2),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: const Icon(Icons.settings,
                                    color: LightColors.kDarkBlue, size: 25.0),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/settings');
                                },
                              ),
                            ),
                            const Text(
                              'AI Chatbot',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 22),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: const Icon(Icons.notifications,
                                color: LightColors.kDarkBlue, size: 25.0),
                            onPressed: () {
                              Navigator.pushNamed(context, '/notification');
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CircularPercentIndicator(
                            radius: 45.0,
                            lineWidth: 5.0,
                            animation: true,
                            percent: 1,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: LightColors.kRed,
                            backgroundColor: LightColors.kDarkYellow,
                            center: CircleAvatar(
                              backgroundColor: LightColors.kBlue,
                              radius: 35.0,
                              backgroundImage: gender == 0
                                  ? const AssetImage(
                                      'assets/images/avatar.png',
                                    )
                                  : const AssetImage(
                                      'assets/images/female.png'),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 22.0,
                                    color: LightColors.kDarkBlue,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          card(),
                          subheading('Location nearby'),
                          const SizedBox(height: 5.0),
                          for (int i = 0; i < cards_list.length; i += 2)
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/details',
                                        arguments: {
                                          'keyword': cards_list[i]['page'],
                                        },
                                      );
                                    },
                                    child: HomeCard(
                                      cardColor: colors[i % 3],
                                      icon: cards_list[i]['icon'],
                                      title: cards_list[i]['name'],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20.0),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/details',
                                        arguments: {
                                          'keyword': cards_list[i + 1]['page'],
                                        },
                                      );
                                    },
                                    child: HomeCard(
                                      cardColor: colors[(i + 1) % 3],
                                      icon: cards_list[i + 1]['icon'],
                                      title: cards_list[i + 1]['name'],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/chatbot');
        },
        child: const Icon(Icons.border_top),
      ),
    );
  }
}

class MyCard3 extends StatelessWidget {
  final String title;
  final String description;

  const MyCard3({super.key, required this.title, required this.description});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: LinearGradient(
            colors: [Colors.yellow.shade400, Colors.yellow.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(description,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
                maxLines: 3),
            const SizedBox(height: 12.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Learn more',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(width: 4.0),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class card extends StatelessWidget {
  const card({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height:
            MediaQuery.of(context).size.width * 0.32, // Set the desired height
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/govt');
          },
          child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              color: const Color.fromARGB(255, 137, 181, 218),
              child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'Governament shemes',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text('Card Subtitle'),
                      leading: Icon(Icons.newspaper),
                    ),
                  ])),
        ));
  }
}
