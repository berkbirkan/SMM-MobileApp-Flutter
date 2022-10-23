import 'package:bimedya/main.dart';
import 'package:bimedya/order_details.dart';
import 'package:bimedya/payment_page.dart';
import 'package:bimedya/strings.dart';
import 'package:bimedya/utils/Json.dart';
import 'package:bimedya/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'models/ServiceModel.dart';



// ignore: must_be_immutable
class PackageDetail extends StatefulWidget {
  String category;
  String catid;

  @override
  _PackageDetailState createState() => _PackageDetailState(category: category,catid: catid,services: []);

  PackageDetail({this.category,this.catid});
}

class _PackageDetailState extends State<PackageDetail> {
  String category;
  String catid;
  List<ServiceModel> services;

  _PackageDetailState({this.category,this.catid,this.services});



  @override
  void initState() {

    getServices(catid,devicelanguage).then((value) => {
      setState(() {

        print(value);
        services = value;

      }),
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(packagestitle),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetails(),
                ),
              );
            },
            icon: Icon(
              Icons.shopping_basket,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                     
                      Text(
                        services[index].name,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.white),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                       Text(
                        "Amount : ${services[index].amount}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                      ),SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(
                                    color: Colors.white,
                                  )),
                              onPressed: () {},
                              color: Colors.white,
                              textColor: primaryColor,
                              child: Text(
                                  services[index].price + " Credit",
                                  style: TextStyle(fontSize: 14, color: primaryColor)),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(
                                    color: Colors.white,
                                  )),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentPage(
                                      service: services[index],
                                    ),
                                  ),
                                );
                              },
                              color: Colors.white,
                              textColor: Colors.white,
                              child: Text(buybutton.toUpperCase(),
                                  style: TextStyle(fontSize: 14, color: primaryColor)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: services.length,
            ),
          )
        ],
      ),
    );
  }
}
