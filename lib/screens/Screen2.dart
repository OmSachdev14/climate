import 'dart:convert';

import 'package:climate/screens/newpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  

  final CityNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void getweatherfromcity(String citynamee) async {
    var apiKey = "dc98213225b10c8b5f3fafa25802811a";
    var apiURL =
        "https://api.openweathermap.org/data/2.5/weather?q=cityname&appid=dc98213225b10c8b5f3fafa25802811a";
    var URL = Uri.https("api.openweathermap.org", "/data/2.5/weather", {
      'q': citynamee.toString(),
      'appid': 'dc98213225b10c8b5f3fafa25802811a',
    });
    var responsee = await http.get(URL);
    var cityweatherdata = jsonDecode(responsee.body);
    // print(cityweatherdata);
    String Cityname = (cityweatherdata['name']);
    String Country = (cityweatherdata['sys']['country']);

    double TempMin = (cityweatherdata['main']['temp_min']);
    double TempMax = (cityweatherdata['main']['temp_max']);
    double Temp = (cityweatherdata['main']['temp']);
    double FeelsLike = (cityweatherdata['main']['feels_like']);
    String Description = (cityweatherdata['weather'][0]['description']);
    DateTime RightNow = DateTime.now();

    // Format 1: Full date and time (e.g., Aug 29, 2025, 9:55 AM)
    String FormattedDateTime = DateFormat(
      'MMM d, yyyy, h:mm a',
    ).format(RightNow);

    // Format 2: Date only (e.g., 29/08/2025)
    String FormattedDate = DateFormat('dd/MM/yyyy').format(RightNow);

    // Format 3: Day of the week (e.g., Friday)
    String FormattedDay = DateFormat('EEEE').format(RightNow);

    // Format 4: Time only with seconds (e.g., 09:55:01 AM)
    String FormattedTime = DateFormat('hh:mm:ss a').format(RightNow);
    // print(cityweatherdata);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Newpage(
          cityname: Cityname,
          country: Country,
          feels_like: FeelsLike,
          temp_min: TempMin,
          temp_max: TempMax,
          temp: Temp,
          description: Description,
          formattedDateTime: FormattedDateTime,
          formattedDate: FormattedDate,
          formattedDay: FormattedDay,
          formattedTime: FormattedTime,
        ),
      ),
    );
  }
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/screen2.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.arrow_back, size: 50, color: Colors.white),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: CityNameController,
                    style: TextStyle(height: 1.5, fontSize: 25),
                    decoration: InputDecoration(
                      hint: Text(
                        "Enter City Name ",
                        style: TextStyle(fontSize: 22),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      String cityname = CityNameController.text;
                      getweatherfromcity(cityname);
                    },
                    child: Text(
                      "Get Weather",
                      style: TextStyle(fontSize: 30, height: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
