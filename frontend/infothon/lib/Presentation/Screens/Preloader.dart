import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../data/shared_preferences.dart';
import 'HomePage.dart';

class Preloader extends StatefulWidget {
  const Preloader({super.key});

  @override
  State<Preloader> createState() => _PreloaderState();
}

class _PreloaderState extends State<Preloader> {
  @override
  void initState() {
    super.initState();
    () async {
      var prefs = await SharedPreferences.getInstance();
      // try {
      //   // Get current location
      //   Position position = await Geolocator.getCurrentPosition(
      //     desiredAccuracy: LocationAccuracy.high,
      //   );

      //   // Reverse geocoding to get the state
      //   List<Placemark> placemarks = await placemarkFromCoordinates(
      //     position.latitude,
      //     position.longitude,
      //   );

      //   String state = placemarks.first.administrativeArea ?? 'Unknown State';
      //   preferences.setString('latitude', '${position.latitude}');
      //   preferences.setString('longitude', '${position.longitude}');
      //   preferences.setString('state', state);
      //   print('State: $state');
      //   print('Latitude: ${position.latitude}');
      //   print('Longitude: ${position.longitude}');
      // } catch (e) {
      //   var status = await Geolocator.checkPermission();
      //   if (status == LocationPermission.denied) {
      //     status = await Geolocator.requestPermission();
      //     if (status == LocationPermission.deniedForever) {
      //       // The user denied permission and selected "Don't ask again"
      //       // Display a message or prompt the user to enable the permission manually
      //     } else if (status == LocationPermission.denied) {
      //       // The user denied permission
      //       // You may want to display a message or try again later
      //     } else {
      //       // Permission granted, proceed with obtaining the location
      //       Position position = await Geolocator.getCurrentPosition(
      //         desiredAccuracy: LocationAccuracy.high,
      //       );
      //       preferences.setString('latitude', '${position.latitude}');
      //       preferences.setString('longitude', '${position.longitude}');
      //       print('Latitude: ${position.latitude}');
      //       print('Longitude: ${position.longitude}');
      //     }
      //   }
      // }
      // const baseUrl = 'https://hackathon.aldoiris.online/api/get_data/';
      // var response = await http.post(Uri.parse(baseUrl), body: {
      //   'latitude': prefs.getString('latitude'),
      //   'longitude': prefs.getString('longitude')
      // });

      // if (response.statusCode == 200) {
      //   prefs.setString('data', response.body);
      // }
    //   name=prefs.getString('name');
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: initializeSharedPreferences(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                  color: const Color.fromARGB(255, 12, 110, 42),
                  size: 50,
                )),
                const Text('Location Guider',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error fetching data: ${snapshot.error}'),
            ),
          );
        } else {
          return HomePage();
        }
      },
    ));
  }
}
