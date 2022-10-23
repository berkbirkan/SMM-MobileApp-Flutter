import 'dart:async';
import 'dart:convert';
import 'package:bimedya/models/CategoryModel.dart';
import 'package:bimedya/models/MediasModel.dart';
import 'package:bimedya/models/ServiceModel.dart';
import 'package:http/http.dart' as http;

import '../config.dart';


Future<List<MediasModel>> getMedias(String language) async {

  List<MediasModel> medias = [];

  var response = await http.get(serverurl + "/socialmedia/list/" + language);
  print("jsondata:");

  var jsonData = jsonDecode(response.body);
  print(jsonData);

  for(var media in jsonData){
    var name = "";
    if (media[language] != null){
      name = media[language];
    }else{
      name = media["socialmedia_name"];
    }
    var id = media["socialmedia_id"];

    var url = media["socialmedia_url"];

    medias.add(MediasModel(id: id,name: name,url: url));

  }


  return medias;



}

Future<List<CategoryModel>> getCategories(String categoryid,String language) async {

  List<CategoryModel> categories = [];

  var response = await http.get(serverurl + "/category/list/" + categoryid.toString() + "/" + language);
  print("jsondata:");

  var jsonData = jsonDecode(response.body);
  print(jsonData);

  for(var category in jsonData){
    var name = "";
    if(category[language] != null){
      name = category[language];
    }else{
      name = category["category_name"];
    }
    var catid = category["category_id"];

    var mediaid = category["socialmedia_id"];
    categories.add(CategoryModel(catid: catid,name: name,mediaid: mediaid));
  }


  return categories;

}

Future<List<ServiceModel>> getServices(String catid,String language) async {

  List<ServiceModel> services = [];

  var response = await http.get(serverurl + "/service/list/" + catid + "/" + language);
  print("jsondata:");

  var jsonData = jsonDecode(response.body);
  print(jsonData);

  for(var service in jsonData){
    var name = "";
    if(service[language] != null){
      name = service[language];
    }else{
      name = service["service_name"];
    }

    var serviceid = service["service_id"];
    var price = service["provider_price"];
    var amount = service["provider_amount"];
    var providerurl = service["provider_url"];
    var providerkey = service["provider_api_key"];
    var catid = service["category_id"];

    services.add(ServiceModel(name: name,serviceid: serviceid,price: price,amount: amount,providerurl: providerurl,providerkey: providerkey,catid: catid));



  }


  return services;

}

// login

Future<dynamic> login(String username,password) async {

  Map params = {
    "user_username": username,
    "user_password": password,
  };

  var response = await http.post(serverurl + "/login",body: params);
  print("jsondata:");

  var jsonData = jsonDecode(response.body);
  print(jsonData);

  return jsonData;

}

//register

Future<dynamic> register(String username,password,name,surname,email) async {
  Map params = {
    "user_username":username,
    "user_password":password,
    "user_name":name,
    "user_surname":surname,
    "user_email":email,
  };

  var response = await http.post(serverurl + "/register",body: params);
  print("jsondata:");

  var jsonData = jsonDecode(response.body);
  print(jsonData);

  return jsonData;


}

//credit

Future<dynamic> addCredit(String username,String amount) async {
  Map params = {
    "user_username":username,
    "user_amount":amount,
  };

  var response = await http.post(serverurl + "/credit/add",body: params);
  print("jsondata:");

  var jsonData = jsonDecode(response.body);
  print(jsonData);

  return jsonData;

}

Future<dynamic> removeCredit(String username, String amount) async {
  Map params = {
    "user_username":username,
    "user_amount":amount,
  };
  var response = await http.post(serverurl + "/credit/remove",body: params);
  print("jsondata:");

  var jsonData = jsonDecode(response.body);
  print(jsonData);

  return jsonData;

}

Future<dynamic> getProfile(String username) async {

  Map params = {
    "user_username":username,

  };

  var response = await http.post(serverurl + "/user/list",body: params);
  print("jsondata:");

  var jsonData = jsonDecode(response.body);
  print(jsonData);

  return jsonData;

}

Future<void> getMediaimage(String mediaid) async {
  var response = await http.get(serverurl + "/socialmedia/list/" + mediaid);
  print("jsondata:");

  var jsonData = jsonDecode(response.body);
  print(jsonData);

  return jsonData;
}

Future<dynamic> getPayments() async {
  var response = await http.get(serverurl + "/payment/list");
  print("jsondata:");

  var jsonData = jsonDecode(response.body);
  print(jsonData);

  return jsonData;
}




