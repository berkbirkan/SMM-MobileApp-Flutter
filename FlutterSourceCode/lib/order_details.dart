import 'dart:convert';

import 'package:bimedya/order_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
  var orderId;
  OrderDetails({this.orderId});
}

class _OrderDetailsState extends State<OrderDetails> {
  List<OrderModel> _orders = List<OrderModel>();

  Future<List<OrderModel>> fetchOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String services = prefs.getString("services");
    String links = prefs.getString("links");
    String servicenames = prefs.getString("names");
    String providerurls = prefs.getString("providerurl");
    String providerkeys = prefs.getString("providerkey");
    String prices = prefs.getString("prices");

    var notes = List<OrderModel>();

    print("SERVİCES:");
    var type = "";
    var j = 0;
    for(var deneme in services.split(",")){
      await checkOrderStatus(providerurls.split("---")[j], providerkeys.split("---")[j], deneme).then((value) => {
      type = "facebook",
        notes.add(OrderModel(orderid: services.split(",")[j] ?? services,servicename: servicenames.split("deneme2")[j] ?? "Service Name",link:links.split("---")[j] ?? links, price: prices.split(",")[j],status: value["status"].toString(),startcount: value["start_count"].toString(),remains: value["remains"].toString(),currency: value["currency"].toString(),iconurl: type))
      });
      j++;
    }

    return notes;






  }
  
 

  @override
  void initState() {
    fetchOrders().then((value) {
      setState(() {
        _orders.addAll(value);
      });
    });
    super.initState();
  }

  Future<Map<String, dynamic>> checkOrderStatus(String providerurl,providerkey,orderid) async {
    var url = providerurl;

    Map params = {
      "key":providerkey,
      "action":"status",
      "order":orderid
    };

    var response = await http.post(url,body: params);
    var jsonData = jsonDecode(response.body);


    
    return jsonData;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Detail"),
        backgroundColor: Color.fromRGBO(57, 119, 254, 1),
      ),
      body: (_orders.length == 0) ? Container(child: Text("There is no order"),) :  _buildListViewInstagram(),
    );
  }

  Widget _buildListViewInstagram() {
    return ListView.builder(
      itemCount: _orders.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(left: 8, top: 8, right: 8),
          padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Color.fromRGBO(57, 119, 254, 1),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: new BoxDecoration(
                        color: Colors.transparent, //new Color.fromRGBO(255, 0, 0, 0.0),
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(40.0),
                          topRight: const Radius.circular(40.0),
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                        )),
                    width: 40.0,
                    height: 40.0,
                    child: Image.asset(
                      "assets/" + "marketshop.png",
                      fit: BoxFit.cover,
                      width: 40.0,
                      height: 40.0,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 80.0,
                        height: 20,
                        child: MarqueeWidget(
                          text:
                              _orders[index].servicename,
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w500),
                          scrollAxis: Axis.horizontal,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 80.0,
                        height: 20,
                        child: MarqueeWidget(
                          text: _orders[index].link,
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w500),
                          scrollAxis: Axis.horizontal,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 80.0,
                        height: 20,
                        child: Text(
                          "Status : " + _orders[index].status,
                          style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                //color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          _orders[index].orderid,
                          style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "ID",
                          style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          _orders[index].price,
                          style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "PRİCE",
                          style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          _orders[index].remains,
                          style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "REMAINS",
                          style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          _orders[index].startcount ?? "0",
                          style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "COUNT",
                          style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
