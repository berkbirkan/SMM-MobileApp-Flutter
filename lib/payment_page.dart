import 'dart:io';
import 'dart:math';
import 'dart:convert';

import 'package:bimedya/models/ServiceModel.dart';
import 'package:bimedya/payment_navigation.dart';
import 'package:bimedya/strings.dart';
import 'package:bimedya/utils/Json.dart';
import 'package:bimedya/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:get_ip/get_ip.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'order_details.dart';

var isPaytr = false;
var isStripe = true;

var link = "";
var amount = 0;
var servicename = "SERVICE";

final navigatorKey = GlobalKey<NavigatorState>();

BuildContext denemecontext;

void showAlertDialog(BuildContext context, String message, String title) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () => {Navigator.pop(context)},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//MESSAGEVİEW

// ignore: must_be_immutable
class MessageView extends StatefulWidget {
  String message;
  bool issuccess;
  String title;
  @override
  _MessageView createState() => _MessageView(message: message, title: this.title, issuccess: issuccess);
  MessageView({this.message, this.title, this.issuccess});
}

class _MessageView extends State<MessageView> {
  String message;
  String title;
  bool issuccess;
  _MessageView({this.message, this.title, this.issuccess});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Text(message),
    );
  }
}

// ORDERVİEW

class OrdersView extends StatefulWidget {
  @override
  _OrdersView createState() => _OrdersView();
}

class _OrdersView extends State<OrdersView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//WEBVIEW


Future<bool> paytrcheck (String checkid) async {
  var paytrpayments = await http.get('https://gtmedya.com/paytr_payments.txt');
  var paytrpaymentsjson = (paytrpayments.body.isNotEmpty ? json.decode(paytrpayments.body) : []);

  return (paytrpaymentsjson.containsKey(checkid) && paytrpaymentsjson[checkid] == 'success');
}


Future<void> addOrderList(String serviceid, String link,String providerurl,String providerkey,String credit) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String allorders = prefs.getString("services") ?? "";
  String alllink = prefs.getString("links") ?? "";
  String servicenames = prefs.getString("names") ?? "";
  String providerurls = prefs.getString("providerurl") ?? "";
  String providerkeys = prefs.getString("providerkey") ?? "";
  String price = prefs.getString("prices") ?? "";



  if (allorders == "") {
    prefs.setString("services", serviceid);
  } else {
    prefs.setString('services', allorders + "," + serviceid);
  }

  if (price == "") {
    prefs.setString("prices", credit);
  } else {
    prefs.setString('prices', price + "," + credit);
  }

  if (alllink == "") {
    prefs.setString("links", link);
  } else {
    prefs.setString("links", alllink + "---" + link);
  }

  if (providerurls == "") {
    prefs.setString("providerurl", providerurl);
  } else {
    prefs.setString("providerurl", providerurls + "---" + providerurl);
  }

  if(providerkeys == ""){
    prefs.setString("providerkey", providerkey);
  }else{
    prefs.setString("providerkey",providerkeys + "---" + providerkey);
  }



  if (servicenames == "") {
    prefs.setString("names", servicename ?? "Service Name");
  } else {
    prefs.setString("names", servicenames + "deneme2" + servicename ?? "Service Name");
  }


}

Future<void> orderPackage(BuildContext context, String providerurl, String providerkey ,String serviceid, String link,String servicename,String amount,String credit) async {
  print("SERVİCE ID: " + serviceid);
  print("LİNK : " + link);
  print("AMOUNT: " + amount);

  Map parameters = {
    "key": providerkey,
    "action": "add",
    "service": serviceid,
    "link": link,
    "quantity": amount,
  };

  // ignore: unused_local_variable
  Map<String, String> headers = {
    "Content-Type": "application/x-www-form-urlencoded",
    "Accept": "application/json"
  };

  // ignore: unused_local_variable
  var bodyEncoded = json.encode(parameters);
  print("AMOUNT: " + amount.toString());
  var response = await http.post(providerurl,body: parameters);
  var jsonData = jsonDecode(response.body);
  print("JSONDATA:");
  print(jsonData);
  print(jsonData["order"]);

  // ignore: unused_local_variable
  var orderid = jsonData["order"] != null ? jsonData["order"] : null;
  //showAlertDialog(context, "jsonData.toString()", "Alert");

  if (jsonData["order"] == null) {
    //error
    print(jsonData);
    showAlertDialog(context, "Error", jsonData["error"]);
/*
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: new Text("Hata"),
          content: new Text(jsonData["error"].toString()),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Tamam"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentNavigation(
                      result: "Başarısız",
                    ),
                  ),
                );
              },
            )
          ],
        ));

 */
  } else {

    addOrderList(jsonData["order"].toString(), link,providerurl,providerkey,credit);
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: new Text("Success"),
          content: new Text(
              "Your order has been successfully processed! Order number : " + jsonData["order"].toString()),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("OK"),
              onPressed: () {
                //burada ali
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentNavigation(
                      result: "Success",
                      orderId: jsonData["order"],
                    ),
                  ),
                );
              },
            )
          ],
        ));
  }
}

//WEBVIEW

// ignore: must_be_immutable
class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
  //String title, price, amount, serviceid, servicename,providerurl,providerkey;
  ServiceModel service;

  PaymentPage({this.service});
}

class CreditCardFormWidget extends StatefulWidget {
  @override
  _CreditCardFormWidgetState createState() => _CreditCardFormWidgetState();
}

class _CreditCardFormWidgetState extends State<CreditCardFormWidget> {
  String cardNumber, expiryDate, cardHolderName, cvvCode;
  bool isCvvFocused = false;

  Future<void> paywithPaymes() async {
    print("deneme");

    String ipAddress = await GetIp.ipAddress;

    Map parameters = {
      "secret": "8ef09d057c158e6",
      "operationId": Random().nextInt(100000000).toString(),
      "number": cardNumber,
      "installmentsNumber": "1",
      "expiryMonth": expiryDate.split("/")[0],
      "expiryYear": expiryDate.split("/")[1],
      "cvv": cvvCode,
      "owner": cardHolderName,
      "billingFirstname": cardHolderName.split(" ")[0],
      "billingLastname": cardHolderName.split(" ")[1],
      "billingEmail": "info@berkbirkan.com",
      "billingPhone": "05522071696",
      "billingCountrycode": "TR",
      "billingAddressline1": "sds",
      "billingCity": "Antalya",
      "deliveryFirstname": cardHolderName.split(" ")[0],
      "deliveryLastname": cardHolderName.split(" ")[1],
      "deliveryPhone": "05522071696",
      "deliveryAddressline1": "deneme",
      "deliveryCity": "Antalya",
      "clientIp": ipAddress,
      "productName": "Takipçi",
      "productSku": "deneme",
      "productQuantity": "1",
      "productPrice": "2.00",
      "currency": "TRY",
      "comment": "deneme",
    };
    // ignore: unused_local_variable
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json"
    };

    // ignore: unused_local_variable
    var bodyEncoded = json.encode(parameters);
    var response = await http.post("https://web.paym.es/api/authorize",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
          HttpHeaders.acceptHeader: 'application/x-www-form-urlencoded'
        },
        body: parameters);
    var jsonData = jsonDecode(response.body);
    print(jsonData);

    if (jsonData["status"] == "SUCCESS") {
      print("success");
    }
    //https://web.paym.es/api/authorize
  }

  Future<void> paywithPayHesap(String amount) async {
    String customer = {
      "firstname": "berk",
      "lastname": "birkan",
      "email": "info@berkbirkan.com",
      "phone": "05522071696",
      "city": "antalya",
      "state": "konyaalti",
      "address": "akkuyu mah",
    }.toString();
    String parameters = {
      "hash": "80",
      "amount": "10.00",
      "order_id": Random().nextInt(100000000).toString(),
      "currency": "TRY",
      "cardnumber": cardNumber,
      "cardcustomername": cardHolderName,
      "cardexpmonth": expiryDate.split("/")[0],
      "cardexpyear": expiryDate.split("/")[1],
      "cardcvv": cvvCode,
      "installment": "1",
      "customer": customer
    }.toString();
    Map<String, String> headers = {"Content-type": "application/json"};
    var response = await http.post("https://www.payhesap.com/api/pay", headers: headers, body: parameters);

    var jsonData = jsonDecode(response.body);

    print(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    denemecontext = context;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Ödeme Formu"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                cardNumber: cardNumber ?? "",
                expiryDate: expiryDate ?? "",
                cardHolderName: cardHolderName ?? "",
                cvvCode: cvvCode ?? "",
                showBackView: isCvvFocused ?? false,
                cardBgColor: Colors.black,
                height: 175,
                textStyle: TextStyle(color: Colors.yellowAccent),
                width: MediaQuery.of(context).size.width,
                animationDuration: Duration(milliseconds: 1000),
              ),
              CreditCardForm(
                themeColor: Colors.red,
                onCreditCardModelChange: (CreditCardModel data) {
//hocam bu kısım zaten yok kullanmıyoruz burayı
                  setState(() {
                    cardNumber = data.cardNumber;
                    expiryDate = data.expiryDate;
                    cardHolderName = data.cardHolderName;
                    if (data.isCvvFocused) {
                      isCvvFocused = true;
                    } else {
                      isCvvFocused = false;
                    }
                    cvvCode = data.cvvCode;
                  });
                },
              ),
              InkWell(
                onTap: () => {paywithPaymes()},
                child: Container(
                  margin: EdgeInsets.only(top: 15.0),
                  height: 50.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text("SATIN AL"),
                ),
              )
            ],
          ),
        ));
  }
}

//            child: Column(children: [Text("Order example: http: // & https://abc.com/username"),Text("Be sure to write the URL before ordering!  For a credit refund for incorrect orders, please contact: iletisim@emreguzel.com.tr.")],),

class _PaymentPageState extends State<PaymentPage> {
  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            child: Column(
              children: [
                Text(
                  infotitle,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "Order example: http: // & https://abc.com/username",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "Be sure to write the URL before ordering!  For a credit refund for incorrect orders, please contact: iletisim@emreguzel.com.tr.",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.all(40.0),
          );
        });
  }

  void _showModalSheet2() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            child: Column(
              children: [
                Text(
                  infotitle,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  info1,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  info2,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.all(40.0),
          );
        });
  }



  Future<void> buyPackage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(link == ""){
      showAlertDialog(context, "Textfield cannot be empty", "Error");
    }else{

      print(prefs.getString("username"));

      removeCredit(prefs.getString("username"), widget.service.price).then((value) => {
        if(value["status"] == "true"){
          orderPackage(context, widget.service.providerurl, widget.service.providerkey, widget.service.serviceid, link, widget.service.name,widget.service.amount,widget.service.price)
        }else{
          showAlertDialog(context, value["message"], "Error"),
        }
      });
    }
  }

  /*

  Future<void> deneme(int amount, String link) async {
    String locale = await Devicelocale.currentLocale;
    servicename = widget.title;

    if (amount == 0 || link == "") {
      showAlertDialog(context, "Textfield cannot be empty", "Error");
    } else {
      print("LOCALE: ");
      print(locale);
      if (amount > int.parse(widget.min) && amount < int.parse(widget.max)) {
        var user = {
          'name': 'Ali Yılmaz',
          'phone': '+905551233265',
          'email': 'ali@yilmaz.com',
          'address': 'Istanbul'
        };
        double total = (double.parse(widget.price) / 1000) * amount;
        var products = [
          {'name': widget.title, 'qty': '1', 'total': total.toStringAsFixed(2)}
        ];

        if (locale != "tr_TR") {
          paywithStripe(products, widget.title, context);
        } else {
          paywithPaytr(user, products, widget.title, context);
        }


      } else {
        showAlertDialog(context, " Min: " + widget.min + " Max: " + widget.max, "Error");
      }
    }
  }

   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BUY"),
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
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                  height: 200.0,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "INFORMATION",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                                  child: RaisedButton(
                                    padding: EdgeInsets.all(10.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        side: BorderSide(
                                          color: primaryColor,
                                        )),
                                    onPressed: _showModalSheet,
                                    color: Colors.white,
                                    textColor: Colors.white,
                                    child: Text("Attention 1".toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14, color: primaryColor)),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                                  child: RaisedButton(
                                    padding: EdgeInsets.all(10.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        side: BorderSide(
                                          color: primaryColor,
                                        )),
                                    onPressed: _showModalSheet2,
                                    color: Colors.white,
                                    textColor: Colors.white,
                                    child: Text("Attention 2".toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14, color: primaryColor)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 150.0,
                        child: Image.asset("assets/images/socialmedia.png",width: 250,height: 250,),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 1.0,
                  color: Colors.black.withOpacity(0.1),
                  margin: EdgeInsets.only(top: 25.0),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "BUY",
                        style: TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.w300),
                      ),
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
                          Icons.home,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                    height: 300.0,
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
                        Container(
                          margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
                          child: Text("${widget.service.name} USD".toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, color: Colors.black)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 200.0,
                              child: Image.asset("assets/images/creditcard.png",width: 150,height: 150,),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "${widget.service.price}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                child: Icon(Icons.attach_money),
                                              ),
                                              Text(
                                                "CREDIT",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w300),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                Container(
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
                  margin: EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20.0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.0,
                      ),
                      TextFormField(
                        onChanged: (text) {
                          link = text;
                        },
                        cursorColor: Theme.of(context).cursorColor,
                        //  initialValue: 'Input text',
                        maxLength: 100,
                        decoration: InputDecoration(
                          icon: Icon(Icons.account_circle),
                          labelText: 'Username / Profile / Link',
                          labelStyle: TextStyle(
                            color: primaryColor,
                          ),
                          helperText: 'Max length',
                          suffixIcon: Icon(
                            Icons.check_circle,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7.0,
                      ),/*
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          amount = int.parse(text);
                        },
                        cursorColor: Theme.of(context).cursorColor,
                        //  initialValue: 'Input text',
                        maxLength: 20,
                        decoration: InputDecoration(
                          icon: Icon(Icons.shopping_cart),
                          labelText: 'Amount',
                          labelStyle: TextStyle(
                            color: primaryColor,
                          ),
                          helperText: 'Max length',
                          suffixIcon: Icon(
                            Icons.check_circle,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                        ),
                      ),*/
                      InkWell(
                        onTap: () => {
                          print(amount),
                          //deneme(amount, link), BUY
                          buyPackage()
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15.0),
                          height: 50.0,
                          alignment: Alignment.center,
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
                          child: Text(
                            "BUY",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Warning ! Read Before Buy",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 14.0,
                            decoration: TextDecoration.underline),
                      ),
                      Text(
                        packdesc1,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        packdesc2,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        packdesc3,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        packdesc4,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        packdesc5,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
