import 'dart:convert';

import 'package:climate/screens/Screen2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'home_screen.dart';

class Newpage extends StatefulWidget {
  final String cityname;
  final String country;
  final double feels_like;
  final double temp_min;
  final double temp_max;
  final double temp;
  final String description;
  // Format 1: Full date and time (e.g., Aug 29, 2025, 9:55 AM)
  final String formattedDateTime;
  // Format 2: Date only (e.g., 29/08/2025)
  final String formattedDate;
  // Format 3: Day of the week (e.g., Friday)
  final String formattedDay;
  // Format 4: Time only with seconds (e.g., 09:55:01 AM)
  final String formattedTime;
  const Newpage({
    super.key,
    required this.cityname,
    required this.country,
    required this.feels_like,
    required this.temp_min,
    required this.temp_max,
    required this.temp,
    required this.description,
    required this.formattedDateTime,
    required this.formattedDate,
    required this.formattedDay,
    required this.formattedTime,
  });

  @override
  State<Newpage> createState() => _NewpageState();
}

String apiKey = 'dc98213225b10c8b5f3fafa25802811a';

class _NewpageState extends State<Newpage> {
  double temp_kelvin(double a) {
    double newtemp = a - 273.15;
    return newtemp;
  }

  @override


  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/screen1.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50,
                        color: Colors.greenAccent,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Screen2()),
                        );
                      },
                      child: Icon(
                        Icons.pin_drop,
                        size: 50,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  '${widget.cityname}, ${widget.country}',
                  style: TextStyle(fontSize: 50, color: Colors.yellowAccent),
                ),
              ),
              Center(
                child: Text(
                  "${temp_kelvin(widget.temp).toStringAsFixed(2)}°",
                  style: TextStyle(fontSize: 30, color: Colors.greenAccent),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${temp_kelvin(widget.temp_max).toStringAsFixed(2)}° ",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                        Text(
                          "⬆️",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Text(
                          "${temp_kelvin(widget.temp_min).toStringAsFixed(2)}° ",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.yellowAccent,
                          ),
                        ),
                        Text("⬇️", style: TextStyle(fontSize: 30)),
                      ],
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  "Discription: ${widget.description}",
                  style: TextStyle(fontSize: 30, color: Colors.greenAccent),
                ),
              ),
              Text(
                "${widget.formattedDate}   ${widget.formattedDay}",
                style: TextStyle(fontSize: 30, color: Colors.lightBlueAccent),
              ),
              Text(
                widget.formattedTime,
                style: TextStyle(fontSize: 30, color: Colors.limeAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
