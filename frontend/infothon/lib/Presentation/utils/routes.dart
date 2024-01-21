import "package:flutter/material.dart";
import "package:infothon/Presentation/Screens/details.dart";
import "../Screens/Chatbot.dart";
import "../Screens/GoverntMentScheme.dart";
import "../Screens/HomePage.dart";
import "../Screens/Login.dart";
import "../Screens/Preloader.dart";
import "../Screens/Settings.dart";

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => HomePage(),
  '/init': (context) => const Preloader(),
  '/chatbot': (context) => const MyChatUI(),
  '/settings': (context) => const SettingPage(),
  '/login': (context) => LoginDemo(),
  '/details': (context) => DisplayContentPage(),
  '/govt': (context) => GovernmentPage(),
};
