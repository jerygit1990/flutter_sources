import 'dart:async';
import 'package:fl_uberapp/src/configs/configs.dart';
import 'package:fl_uberapp/src/model/place_item_res.dart';
import 'package:fl_uberapp/src/model/step_res.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceService {
  static final String key = "AIzaSyD2wvfkq79nsuvbhDLZ-xY5CF_MToWvmIc";
  static Future<List<PlaceItemRes>> searchPlace(String keyword) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?key=" +
            key +
            "&language=vi&region=VN&query=" +
            Uri.encodeQueryComponent(keyword);

    print("search >>: " + url);
    var res = await http.get(url);
    if (res.statusCode == 200) {
      return PlaceItemRes.fromJson(json.decode(res.body));
    } else {
      return new List();
    }
  }

  static Future<dynamic> getStep(
      double lat, double lng, double tolat, double tolng) async {
    String str_origin = "origin=" + lat.toString() + "," + lng.toString();
    // Destination of route
    String str_dest =
        "destination=" + tolat.toString() + "," + tolng.toString();
    // Sensor enabled
    String sensor = "sensor=false";
    String mode = "mode=driving";
    // Building the parameters to the web service
    String parameters = str_origin + "&" + str_dest + "&" + sensor + "&" + mode;
    // Output format
    String output = "json";
    // Building the url to the web service
    String url = "https://maps.googleapis.com/maps/api/directions/" +
        output +
        "?" +
        parameters +
        "&key=" +
        Configs.GG_KEY;

//    String url = "origin=" +
//        lat.toString() +
//        "," +
//        lng.toString() +
//        "&destination=" +
//        tolat.toString() +
//        "," +
//        tolng.toString() +
//        "&key=" +
//        key;
//
//    final BASE_URL = "https://maps.googleapis.com/maps/api/directions/json?";

    print(url);
    final JsonDecoder _decoder = new JsonDecoder();
    return http.get(url).then((http.Response response) {
      String res = response.body;
      int statusCode = response.statusCode;
      print("API Response: " + res);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        res = "{\"status\":" +
            statusCode.toString() +
            ",\"message\":\"error\",\"response\":" +
            res +
            "}";
        throw new Exception(res);
      }

      List<Steps> steps;
      try {
        steps =
            parseSteps(_decoder.convert(res)["routes"][0]["legs"][0]["steps"]);
      } catch (e) {
        throw new Exception(res);
      }

      return steps;
    });
  }

  static List<Steps> parseSteps(final responseBody) {
    var list =
        responseBody.map<Steps>((json) => new Steps.fromJson(json)).toList();

    return list;
  }
}