import 'dart:convert';
import 'dart:math';

import 'package:bimedya/Screens/Profile/profile.dart';
import 'package:bimedya/admin_views/admin_main_view.dart';
import 'package:bimedya/config.dart';
import 'package:bimedya/home_page.dart';
import 'package:bimedya/order_details.dart';
import 'package:bimedya/utils/Json.dart';
import 'package:bimedya/utils/PaypalPayment.dart';
import 'package:bimedya/utils/color.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get_ip/get_ip.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:paypal_mobile_payment/paypal_mobile_payment.dart';

import '../main.dart';
import '../payment_page.dart';
import '../paymentsettings.dart';



// ignore: must_be_immutable
class PayWebView extends StatefulWidget {
  @override
  _PayWebViewState createState() => _PayWebViewState(url: url, success_url: success_url, fail_url: fail_url, checkid: checkid, paymentservice: paymentservice,amo: amo);
  String url;
  // ignore: non_constant_identifier_names
  String success_url;
  // ignore: non_constant_identifier_names
  String fail_url;
  int amount;
  String checkid;
  String paymentservice;
  String amo;
  PayWebView(
      {this.url,
        // ignore: non_constant_identifier_names
        this.success_url,
        // ignore: non_constant_identifier_names
        this.fail_url,

        this.amount,this.checkid,this.paymentservice,this.amo});
}

class _PayWebViewState extends State<PayWebView> {
  String url;
  // ignore: non_constant_identifier_names
  String success_url;
  // ignore: non_constant_identifier_names
  String fail_url;
  int amount;
  String checkid, paymentservice;
  String amo;


  @override
  void initState() {
    // TODO: implement initState
    getUsername();
    super.initState();
    print("deneme 2");



  }

  Future<void> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("username");
  }

  var _controller;
  _PayWebViewState(
      {this.url,
        // ignore: non_constant_identifier_names
        this.success_url,
        // ignore: non_constant_identifier_names
        this.fail_url,
        this.amount,this.checkid,this.paymentservice,this.amo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Payment"),
        ),
        body: WebViewPlus(
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              this._controller = controller;
              controller.loadUrl(url);
            },
            onPageFinished: (url) {
              var pattern = new RegExp('^https:?//(www\.)?');
              url = url.replaceAll(pattern, '');
              success_url = success_url.replaceAll(pattern, '');
              fail_url = fail_url.replaceAll(pattern, '');

              if (url.startsWith(success_url) || url.startsWith(fail_url)) {
                if(url.startsWith(success_url) && paymentservice == 'paytr'){

                  // print("CHECKID : " + checkid);

                  paytrcheck(checkid).then((value) => {
                    if(value){
                      //this._controller.loadString('Successfully paid!'),
                      // orderPackage(context, serviceid, link, servicename),
                      print("success!!!"),
                      addCredit(username, amo).then((value) => {
                        print(value),
                        if(value["message"]["Credit-add"] == "true"){
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.success,
                            text: "Credits successfully added!",
                          )
                        }else{
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            text: value["message"]["Credit-add"].toString(),
                          )
                        }
                      })
                    }else{
                      print("başarısız"),
                      //this._controller.loadStkring('Failed to pay'),

                      Navigator.pop(context),
                    }
                  });
                  ///
                }else{
                  this._controller.loadString((url.startsWith(success_url) ? 'Successfully paid!' : 'Failed to pay'));
                  if(url.startsWith(success_url)){
                    //  orderPackage(context, serviceid, link, servicename);
                    addCredit(username, amo).then((value) => {
                      print(value),
                      if(value["message"]["Credit-add"] == "true"){
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.success,
                          text: "Credits successfully added!",
                        )
                      }else{
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.error,
                          text: value["message"]["Credit-add"].toString(),
                        )
                      }
                    });
                  }else{
                    Navigator.pop(context);
                  }
                }
              }
            }));
  }
}