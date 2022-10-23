import 'dart:convert';
import 'package:bimedya/config.dart';
import 'package:bimedya/home_page.dart';
import 'package:http/http.dart' as http;

class Package {
  String service;
  String type;
  String rate;
  String min;
  String max;
  String name;
  String category;

  Package(
      {this.service,
      this.type,
      this.rate,
      this.min,
      this.max,
      this.name,
      this.category});
}

List<Package> services;

Future<void> getServicesAll() async {
  Map parameters = {"key": "apikey", "action": "services"};
 
  var response = await http.post(serverurl, body: parameters);
  print("jsondata:");

  var jsonData = jsonDecode(response.body);
  print(jsonData);

  for (var service in jsonData) {
    if (service["category"] == null) {
      serviceslist.add(Package(
        service: service["service"],
        type: service["type"],
        rate: service["rate"],
        min: service["min"],
        max: service["max"],
        name: service["name"],
        category: service["name"],
      ));
    } else {
      serviceslist.add(Package(
        service: service["service"],
        type: service["type"],
        rate: service["rate"],
        min: service["min"],
        max: service["max"],
        name: service["name"],
        category: service["category"],
      ));
    }
  }
}
