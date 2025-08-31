import "dart:convert";

import "package:climate/screens/newpage.dart";
import "package:climate/services/location.dart";
import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import 'package:http/http.dart' as http;
import "package:intl/intl.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    if (mounted) {
      getlocation();
    }
    super.initState();
  }

  void getlocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    double lat = location.latitude;
    double lon = location.longitude;
    var apikey = "dc98213225b10c8b5f3fafa25802811a";
    var apiurl =
        "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid=dc98213225b10c8b5f3fafa25802811a";
    var url = Uri.https("api.openweathermap.org", "/data/2.5/weather", {
      "lat": lat.toString(),
      'lon': lon.toString(),
      'appid': apikey,
    });
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String cityname = (data['name']);
      String country = (data['sys']['country']);

      double tempMin = (data['main']['temp_min']);
      double tempMax = (data['main']['temp_max']);
      double temp = (data['main']['temp']);
      double feelsLike = (data['main']['feels_like']);
      String description = (data['weather'][0]['description']);
      DateTime rightNow = DateTime.now();

      // Format 1: Full date and time (e.g., Aug 29, 2025, 9:55 AM)
      String formattedDateTime = DateFormat(
        'MMM d, yyyy, h:mm a',
      ).format(rightNow);

      // Format 2: Date only (e.g., 29/08/2025)
      String formattedDate = DateFormat('dd/MM/yyyy').format(rightNow);

      // Format 3: Day of the week (e.g., Friday)
      String formattedDay = DateFormat('EEEE').format(rightNow);

      // Format 4: Time only with seconds (e.g., 09:55:01 AM)
      String formattedTime = DateFormat('hh:mm:ss a').format(rightNow);
      print(data);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Newpage(
            cityname: cityname,
            country: country,
            feels_like: feelsLike,
            temp_min: tempMin,
            temp_max: tempMax,
            temp: temp,
            description: description,
            formattedDateTime: formattedDateTime,
            formattedDate: formattedDate,
            formattedDay: formattedDay,
            formattedTime: formattedTime,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SpinKitFadingCircle(color: Colors.black, size: 50.0)),
    );
  }
}
