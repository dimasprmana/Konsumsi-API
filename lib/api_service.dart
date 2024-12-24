import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String apiKey = "3d3caf00b5cf1a7036eee564ba2363f0";
  final String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=";

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedData = prefs.getString('weather_$city');

    if (cachedData != null) {
      return json.decode(cachedData);
    } else {
      final response = await http.get(Uri.parse('$apiUrl$city&appid=$apiKey'));
      if (response.statusCode == 200) {
        prefs.setString('weather_$city', response.body);
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load weather data');
      }
    }
  }
}



// class ApiService {
//   final String apiUrl = "https://jsonplaceholder.typicode.com/photos";

//   Future<List<dynamic>> fetchPhotos() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? cachedData = prefs.getString('photos');

//     if (cachedData != null) {
//       return json.decode(cachedData);
//     } else {
//       final response = await http.get(Uri.parse(apiUrl));
//       if (response.statusCode == 200) {
//         prefs.setString('photos', response.body);
//         return json.decode(response.body);
//       } else {
//         throw Exception('Failed to load photos');
//       }
//     }
//   }
// }



// class ApiService {
//   Future<List<dynamic>> fetchPost() async {
//     final response = 
//       await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('gagal syncron');
//     }
//   }
// }
