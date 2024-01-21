import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';
// import 'package:web_scraper/web_scraper.dart';

Future<void> initializeSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
   
      if (responseData.containsKey('notice')) {
        prefs.setString('notice', json.encode(responseData['notice']));
        // print(responseData['notice'].reversed);
      }
      if (responseData.containsKey('event')) {
        prefs.setString('event', json.encode(responseData['event']));
      }
      if (responseData.containsKey('bus')) {
        prefs.setString('bus', json.encode(responseData['bus']));
      }
      if (responseData.containsKey('department')) {
        prefs.setString('department', json.encode(responseData['department']));        
      }
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching data: $error');
    return;
  }
}