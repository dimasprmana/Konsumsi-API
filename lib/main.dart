import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cuaca App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? weatherData;

  void _fetchWeather() async {
    String city = _controller.text;
    if (city.isNotEmpty) {
      var data = await apiService.fetchWeather(city);
      setState(() {
        weatherData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cuaca App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Masukan nama kota',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _fetchWeather,
                ),
              ),
            ),
            SizedBox(height: 20),
            weatherData == null
                ? Text('Masukkan kota untuk mendapatkan data cuaca')
                : Expanded(
                    child: ListView(
                      children: [
                        Text(
                          'kota: ${weatherData!['name']}',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'suhu: ${(weatherData!['main']['temp'] - 273.15).toStringAsFixed(2)} °C',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'cuaca: ${weatherData!['weather'][0]['description']}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Photo Grid",
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: PhotoScreen(),
//     );
//   }
// }

// class PhotoScreen extends StatelessWidget {
//   final ApiService apiService = ApiService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Photos')),
//       body: FutureBuilder<List<dynamic>>(
//         future: apiService.fetchPhotos(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             return GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//               ),
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   elevation: 5,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Image.network(
//                         snapshot.data![index]['thumbnailUrl'],
//                         fit: BoxFit.cover,
//                         height: 120,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           snapshot.data![index]['title'],
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }


// class HomeScreen extends StatelessWidget {
//   final ApiService apiService = ApiService();

//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text("Api-Post")),
//         body: FutureBuilder<List<dynamic>>(
//             future: apiService.fetchPost(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else {
//                 return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(snapshot.data![index]['title']),
//                         subtitle: Text(snapshot.data![index]['body']),
//                       );
//                     });
//               }
//             }));
// }
// }