import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';


class WorldTime{
  String location = ""; // location name for the UI
  String time = ""; // time of location
  String flag = ""; // URL to an asset flag icon
  String url = "";  // location url for api endpoint
  bool isDayTime = false; // true if day, false if night

  WorldTime({ required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    // var url =
    //   Uri.https('jsonplaceholder.typicode.com', '/todos/2');
    // Response response = await get(url);
    // Map data = jsonDecode(response.body);
    // print(data["userId"]);
      try{
        //make request
    Response res = await get( Uri.http('worldtimeapi.org', '/api/timezone/$url'));
    Map data = jsonDecode(res.body);

    // get properties
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1,3);

    // create datetime obj
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    // set time property
    time = DateFormat.jm().format(now);

    // set day/night
    isDayTime = now.hour > 6 && now.hour < 20 ? true:false;

      }
      catch(e) {
        print("caught error: $e");
        time = "could not get time data";
    }


  }
}

