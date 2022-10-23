import 'package:bimedya/home_page.dart';
import 'package:bimedya/order_details.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PaymentNavigation extends StatefulWidget {
  @override
  _PaymentNavigationState createState() => _PaymentNavigationState();
  String result;
  var orderId;
  PaymentNavigation({this.result, this.orderId});
}

class _PaymentNavigationState extends State<PaymentNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.result}"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, top: 15, right: 10),
        padding: EdgeInsets.only(left: 10, top: 30, right: 10),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
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
        child: Column(
          children: [
            Text(
              "Ödeme işleminiz : ${widget.result}",
              style: TextStyle(color: Colors.black, fontSize: 24.0),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(
                          color: Colors.blue,
                        )),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text("HOMEPAGE".toUpperCase(), style: TextStyle(fontSize: 14)),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(
                          color: Colors.blue,
                        )),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetails(
                            orderId: widget.orderId,
                          ),
                        ),
                      );
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text("ORDER DETAILS".toUpperCase(), style: TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
