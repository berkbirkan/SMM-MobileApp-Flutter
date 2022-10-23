import 'dart:convert';
import 'dart:math';
import 'dart:async';
import 'dart:io';
import 'package:bimedya/constants.dart';
import 'package:bimedya/consumable_store.dart';
import 'package:bimedya/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:bimedya/Screens/Profile/profile.dart';
import 'package:bimedya/admin_views/admin_main_view.dart';
import 'package:bimedya/config.dart';
import 'package:bimedya/home_page.dart';
import 'package:bimedya/iap.dart';
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
import '../paymentsettings.dart';
import 'PayWebView.dart';

const bool _kAutoConsume = true;
ProductDetails deger;

List<String> isimler = <String>["Allah'a", "Şükür", "Bitti", "!", "!!", "!!!"];

var user = {
  'name': 'Ali Yılmaz',
  'phone': '+905551233265',
  'email': 'ali@yilmaz.com',
  'address': 'Istanbul'
};

var username = "";
int i = 0;
int reis = 0;

class BuyCredit extends StatefulWidget {
  BuyCredit();
  @override
  _EarnCreditState createState() => _EarnCreditState();
}

class _EarnCreditState extends State<BuyCredit> {
  final InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  List<String> _consumables = [];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String _queryProductError;

  @override
  void initState() {
    Stream purchaseUpdated =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    print(jsonIleCekilenVeri);
    print(jsonIleCekilenVeriIsimler);
    initStoreInfo();
    super.initState();
    getUsername();
    print("deneme 1");
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _connection.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
        _purchases = [];
        _notFoundIds = [];
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    ProductDetailsResponse productDetailResponse =
    await _connection.queryProductDetails(jsonIleCekilenVeri.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    final QueryPurchaseDetailsResponse purchaseResponse =
    await _connection.queryPastPurchases();
    if (purchaseResponse.error != null) {
      // handle query past purchase error..
    }
    final List<PurchaseDetails> verifiedPurchases = [];
    for (PurchaseDetails purchase in purchaseResponse.pastPurchases) {
      if (await _verifyPurchase(purchase)) {
        verifiedPurchases.add(purchase);
      }
    }
    List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _purchases = verifiedPurchases;
      _notFoundIds = productDetailResponse.notFoundIDs;

      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    i = 0;
    super.dispose();
  }

  Future<void> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("username");
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stack = [];
    if (_queryProductError == null) {
      stack.add(
        ListView(
          children: [
            _buildProductList(),
          ],
        ),
      );
    } else {
      stack.add(Center(
        child: Text(_queryProductError),
      ));
    }
    if (_purchasePending) {
      stack.add(
        Stack(
          children: [
            Opacity(
              opacity: 0.3,
              child: const ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(
              child: CupertinoActivityIndicator(),
            ),
          ],
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: stack,
        ),
      ),
    );
  }

  Card _buildProductList() {
    if (_loading) {
      return Card(
          child: (ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Loading...'))));
    }
    if (!_isAvailable) {
      return Card();
    }
    List<Padding> productList = <Padding>[];
    if (_notFoundIds.isNotEmpty) {
      productList.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            title: Text('[${_notFoundIds.join(", ")}]bulunamadı',
                style: TextStyle(color: ThemeData.light().errorColor)),
            subtitle: Text('hata')),
      ));
    }

    //hocam öncelikle şu tasarım sorununu ve sıralama olayını çözelim fonksiyonu açabilir misin bi bakayım paywithiap fonksiyonu

    // This loading previous purchases code is just a demo. Please do not use this as it is.
    // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verify the purchase data.
    Map<String, PurchaseDetails> purchases =
    Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        InAppPurchaseConnection.instance.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));
    productList.addAll(
      _products.map((ProductDetails productDetails) {
        PurchaseDetails previousPurchase = purchases[productDetails.id];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
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
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    // "${isimler[i]}",
                    //  productDetails.id,
                    secimFonksiyonu(productDetails),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (productDetails.id == "10credits") {
                      var products = [
                        {'name': "10 Credits", 'qty': '1', 'total': "10"}
                      ];

                      paySelect(context, 10, "10 Credits", "10credits");
                      deger = productDetails;
                    }
                    if (productDetails.id == "20credits") {
                      var products = [
                        {'name': "20 Credit", 'qty': '1', 'total': "20"}
                      ];

                      paySelect(context, 20, "20 Credits", "20credits");
                      deger = productDetails;
                    }
                    if (productDetails.id == "50credits") {
                      var products = [
                        {'name': "50 Credit", 'qty': '1', 'total': "50"}
                      ];

                      paySelect(context, 50, "50 Credits", "50credits");
                      deger = productDetails;
                    }
                    if (productDetails.id == "100credits") {
                      var products = [
                        {'name': "100 Credit", 'qty': '1', 'total': "100"}
                      ];

                      paySelect(context, 100, "100 Credits", "100credits");
                      deger = productDetails;
                    }
                    if (productDetails.id == "200credits") {
                      var products = [
                        {'name': "200 Credit", 'qty': '1', 'total': "200"}
                      ];

                      paySelect(context, 200, "200 Credits", "200credits");
                      deger = productDetails;
                    }
                    if (productDetails.id == "500credits") {
                      var products = [
                        {'name': "500 Credit", 'qty': '1', 'total': "500"}
                      ];

                      paySelect(context, 500, "500 Credits", "500credits");
                      deger = productDetails;
                    }

                    if (productDetails.id == "1credits") {
                      var products = [
                        {'name': "1 Credit", 'qty': '1', 'total': "1"}
                      ];

                      paySelect(context, 1, "1 Credits", "1credits");
                      deger = productDetails;
                    }

                    if (productDetails.id == "2credits") {
                      var products = [
                        {'name': "2 Credit", 'qty': '1', 'total': "2"}
                      ];

                      paySelect(context, 2, "2 Credits", "2credits");
                      deger = productDetails;
                    }

                    if (productDetails.id == "5credits") {
                      var products = [
                        {'name': "5 Credit", 'qty': '1', 'total': "5"}
                      ];

                      paySelect(context, 5, "5 Credits", "5credits");
                      deger = productDetails;
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: primaryColor,
                    child: Text("PAY " +
                      secimFonksiyonuFiyat(productDetails) + " USD",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );

    return Card(
      child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Icon(Icons.arrow_back_ios),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "BUY CREDİT",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w300),
                  ),
                  Container(
                    child: !isAdmin
                        ? Row(
                      children: [
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
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Profile(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                        : Row(
                      children: [
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
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Profile(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AdminPanelViewPage(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.stars,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider()
          ] +
              productList),
    );
  }

  String secimFonksiyonu(ProductDetails x) {
    return jsonIleCekilenVeriIsimler[jsonIleCekilenVeri.indexOf(x.id)];
  }

  String secimFonksiyonuFiyat(ProductDetails x) {
    return jsonIleCekilenVeriFiyatlar[jsonIleCekilenVeri.indexOf(x.id)];

  }

  Future<void> consume(String id) async {
    await ConsumableStore.consume(id);
    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _consumables = consumables;
    });
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  void deliverProduct(PurchaseDetails purchaseDetails) async {

  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  //bu kısmı test etmemmiz lazım çünkü hocam bi bakallım o kısma android kısmına android studiodan girelim olmazsa ben vs code kullanmmıyorum çünkü anladım da apk imzalama nasıl yapılacak burada ben de onu bilmiyorum :) jks ile imzalayalım önce

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
/*
            if (purchaseDetails.productID == "cirak") {
              FirebaseUser firebase = await FirebaseAuth.instance.currentUser();
              if (firebase.email != null) {
                Firestore.instance
                    .collection('users')
                    .document(firebase.email)
                    .updateData(
                  {'katsayi': "0.00044", 'userType': "ÇIRAK"},
                );
              }
            }
            if (purchaseDetails.productID == "kalfa") {
              FirebaseUser firebase = await FirebaseAuth.instance.currentUser();
              if (firebase.email != null) {
                Firestore.instance
                    .collection('users')
                    .document(firebase.email)
                    .updateData(
                  {'katsayi': "0.00048", 'userType': "KALFA"},
                );
              }
            }
            if (purchaseDetails.productID == "usta") {
              FirebaseUser firebase = await FirebaseAuth.instance.currentUser();
              if (firebase.email != null) {
                Firestore.instance
                    .collection('users')
                    .document(firebase.email)
                    .updateData(
                  {'katsayi': "0.0006", 'userType': "USTA"},
                );
              }
            }
            if (purchaseDetails.productID == "patron") {
              FirebaseUser firebase = await FirebaseAuth.instance.currentUser();
              if (firebase.email != null) {
                Firestore.instance
                    .collection('users')
                    .document(firebase.email)
                    .updateData(
                  {'katsayi': "0.0008", 'userType': "PATRON"},
                );
              }
            }
            */
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }

        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchaseConnection.instance
              .completePurchase(purchaseDetails);
        }
      }
    });
  }

  Future<void> paywithPaytr(Map<dynamic, dynamic> user, List products,
      String servicename, BuildContext context) async {
    var ipaddress = await GetIp.ipAddress;
    final ProgressDialog pr = ProgressDialog(context);
    await pr.show();

    // SETTINGS

    // SALE SETTINGS
    var currency = 'tl', // para birimi
        maxinstallment = '1', // taksit sayısı
        userip = ipaddress,
        username = user["name"],
        useremail = user['email'],
        userphone = user['phone'],
        useraddress = user['address'];

    var userbasketlist = [], amount = 0;

    products.forEach((item) {
      var itemprice =
      int.parse((double.parse(item['total']) * 800).toStringAsFixed(0));
      userbasketlist.add([
        item['name'].replaceAll(new RegExp('[^a-zA-Z0-9ğĞüÜıİşŞöÖçÇ ]+'), ''),
        itemprice.toString(),
        item['qty']
      ]);
      amount += itemprice;
    });

    var userbasket = base64.encode(utf8.encode(json.encode(userbasketlist))),
        amountstr = amount.toString();
    currency = currency.toUpperCase();
    var noinstallment = (maxinstallment == '1') ? '1' : '0',
        merchantoid = DateTime.now().millisecondsSinceEpoch.toString() +
            'PAYTR' +
            Random().nextInt(10000).toString(),
        hashstr = paytrmerchantid +
            userip +
            merchantoid +
            useremail +
            amountstr +
            userbasket +
            noinstallment +
            maxinstallment +
            currency +
            testmode +
            paytrmerchantsalt;
    List<int> messageBytes = utf8.encode(hashstr);
    List<int> key = utf8.encode(paytrmerchantkey);
    Hmac hmac = new Hmac(sha256, key);
    Digest digest = hmac.convert(messageBytes);
    String base64Mac = base64.encode(digest.bytes);
    var paytrtoken = base64Mac;

    Map postparams = {
      'merchant_id': paytrmerchantid,
      'user_ip': userip,
      'merchant_oid': merchantoid,
      'email': useremail,
      'payment_amount': amountstr,
      'paytr_token': paytrtoken,
      'user_basket': userbasket,
      'no_installment': noinstallment,
      'max_installment': maxinstallment,
      'user_name': username,
      'user_address': useraddress,
      'user_phone': userphone,
      'currency': currency,
      'lang': paytrlang,
      'merchant_fail_url': failredirecturl,
      'merchant_ok_url': successredirecturl,
      'test_mode': testmode,
      'debug_on': debugmode
    };

    var response = await http.post('https://www.paytr.com/odeme/api/get-token',
        body: postparams);

    if (response.body.isNotEmpty) {
      var paymentresponse = json.decode(response.body).values.toList();
      if (paymentresponse[0] == 'success') {
        var token = paymentresponse[1];
        print('Success. Token: ' + token);
        await pr.hide();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PayWebView(
                url: "https://www.paytr.com/odeme/guvenli/" + token,
                success_url: successredirecturl,
                fail_url: failredirecturl,
                paymentservice: "paytr",
                amount: amount,
              ),
            ));
        //'https://www.paytr.com/odeme/guvenli/' + token
      } else {
        await pr.hide();
        print("error!");
        print('PayTR token error: ' + paymentresponse[1]);
      }
    }
  }

  Future<void> paywithStripe(List products, String servicename,
      BuildContext context, int amount, String amo) async {
    final ProgressDialog pr = ProgressDialog(context);
    await pr.show();
    // SETTINGS

    // SALE SETTINGS
    var currency = 'usd', // para birimi
        paymentmethod = 'card';

    Map postparams = {
      'locale': stripelanguage,
      'mode': 'payment',
      'success_url': successredirecturl,
      'cancel_url': failredirecturl
    };
    var i = 0;

    products.forEach((item) {
      var istr = i.toString();
      postparams['line_items[' + istr + '][price_data][currency]'] = currency;
      postparams['line_items[' + istr + '][price_data][unit_amount]'] =
          (double.parse(item['total']) * 100).toStringAsFixed(0);
      postparams['line_items[' + istr + '][price_data][product_data][name]'] =
      item['name'];
      //var amount = postparams['line_items[' + i_str + '][price_data][unit_amount]'] =
      (double.parse(item['total']) * 100).toStringAsFixed(0);
      postparams['line_items[' + istr + '][quantity]'] = item['qty'];
      postparams['payment_method_types[' + istr + ']'] = paymentmethod;
      i += 1;
      //total += int.parse(amount);
    });
/*
    Map post_params_2 = {
      'amount': total.toString(),
      'currency': currency,
      'metadata[integration_check]': 'accept_a_payment'
    };


 */
    var response = await http.post(
        'https://api.stripe.com/v1/checkout/sessions',
        headers: {'Authorization': 'Bearer ' + stripesecretkey},
        body: postparams);
    //var response = await http.post('https://api.stripe.com/v1/payment_intents', headers: {'Authorization': 'Bearer ' + stripe_secret_key}, body: post_params_2);

    if (response.body.isNotEmpty) {
      var paymentresponse = json.decode(response.body);
      print("RESPONSE: ");
      print(paymentresponse);
/*
      if(payment_response['client_secret'] != ''){
        print('Success. Client secret: ' + payment_response['client_secret']);

        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            PayWebView(
                url: "assets/stripe_2/index.html?p=" + stripe_publish_key + "&c=" + payment_response['client_secret'],
                success_url: success_redirect_url,
                fail_url: fail_redirect_url,
                serviceid: widget.serviceid,
                link: link,
                amount: amount)
        ));
      }else{
        print('Stripe payment intents error');
      }

 */

      if (paymentresponse['id'] != '') {
        var sessionid = paymentresponse['id'];

        print('Success. Session ID: ' + sessionid.toString());
        await pr.hide();

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PayWebView(
                  url:
                  "https://birkanmedia.com/stripedeneme.html?session_id=" +
                      sessionid,
                  success_url: successredirecturl,
                  fail_url: failredirecturl,
                  amount: amount,
                  amo: amo,
                )));

        // 'https://site.com/stripe.html?session_id=' + session_id
      } else {
        await pr.hide();
        print('Stripe session ID error');
      }
    }
  }

  Future<bool> paytrcheck(String checkid) async {
    var paytrpayments =
    await http.get('https://boostersmm.com/paytr_payments.txt');
    var paytrpaymentsjson =
    (paytrpayments.body.isNotEmpty ? json.decode(paytrpayments.body) : []);

    return (paytrpaymentsjson.containsKey(checkid) &&
        paytrpaymentsjson[checkid] == 'success');
  }

  Future<void> paywithPaypal(BuildContext context,String price,String productname) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalPayment(price: price,productname: productname,
          onFinish: (number) async {
            // payment done
            print('order id: ' + number);

            addCredit(username, price).then((value) => {
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


          },
        ),
      ),
    );
  }

  void paySelect(
      BuildContext context, int amount, String productname, String purchaseid) {

    if(paymenttype == "0"){
      //iap

      paywithIAP(purchaseid, context);
    }else{
      //multi
      var products = [
        {'name': productname, 'qty': '1', 'total': amount.toString()}
      ];

      List<DialogButton> options = [];

      if (paytractive == "1" && devicelanguage == "tr") {
        options.add(DialogButton(
          child: Text(
            "Credit Card (" + amount.toString() + " USD)",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => {
            //paywithStripe(products, productname, context, amount,amount.toString()),
            paywithPaytr(user, products, productname, context),
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ));
      }

      if (stripeactive == "1") {
        options.add(DialogButton(
          child: Text(
            "Credit Card (" + amount.toString() + " USD)",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => {
            paywithStripe(
                products, productname, context, amount, amount.toString()),
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ));
      }

      if (paypalactive == "1") {
        options.add(DialogButton(
          child: Text(
            "Paypal (" + amount.toString() + " USD)",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => {
            paywithPaypal(context,amount.toString(),productname),
          },
          color: Colors.blueAccent,
        ));
      }

      if (iapactive == "1") {
        options.add(DialogButton(
          child: Text(
            "Google Play (" + amount.toString() + " USD)",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => {paywithIAP(purchaseid, context)},
          color: Colors.blueAccent,
        ));
      }

      Alert(
          context: context,
          type: AlertType.info,
          title: "Payment Method",
          desc: "Choose your payment method",
          content: Column(children: options))
          .show();

    }

  }

  void paywithIAP(String purchaseid, BuildContext context) {
    PurchaseParam purchaseParam = PurchaseParam(
        productDetails: deger, applicationUserName: null, sandboxTesting: true);
    _connection.buyConsumable(
        purchaseParam: purchaseParam,
        autoConsume: _kAutoConsume || Platform.isIOS);

    //başarıyla allınndıktan sonra kredi ekleme olayı olacak o nerede
  }

  Future<dynamic> payBitcoin(BuildContext context, int amount) async {
    var ipaddress = await GetIp.ipAddress;

    Map params = {
      "merchant_id": "10043",
      "public_key": "eAieVZ089gpOMR1DZM",
      "secret_key": "G4K9NAKaK5GkD9dzZ0",
      "order_id": "PAYIO" + Random().nextInt(100000).toString(),
      "amount": amount.toString(),
      "currency": "USD",
      "user_ip": ipaddress,
      "testmode": "1"
    };
    var response = await http.post("https://api.payiyo.com/odeme.php",
        headers: {
          'X-SECURITY': 'PayiyoSystemV1',
          'X-Public-Key': 'eAieVZ089gpOMR1DZM'
        },
        body: params);
    print("jsondata:");

    var jsonData = jsonDecode(response.body);
    print(jsonData);

    var bitcoinaddress = jsonData["btc_address"].toString();
    var amounts = jsonData["amount"].toString();
    var qrcode = jsonData["base64"];
    Navigator.pop(context);
    Alert(
        context: context,
        type: AlertType.info,
        title: "BTC",
        desc: "Please send " +
            amount.toString() +
            "USD to BTC walllet. Click SUBMIT after paid.",
        image: Image.asset(
          "assets/images/1.png",
          width: 50,
          height: 50,
        ),
        content: Column(
          children: [
            Container(
              child: Html(
                  data: '<img src="data:image/jpeg;base64,' + qrcode + ' ">'),
              width: 250,
              height: 250,
            ),
            Text("BTC Address: " + bitcoinaddress),
            Text("Amount: " + amounts + " BTC"),
            DialogButton(
              child: Text(
                "SUBMIT",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => {},
              color: Colors.orange,
            )
          ],
        )).show();

    return jsonData;
  }

  void isbtcpaid(
      String orderid,
      ) {
    var params = {
      "merchant_id": "10043",
      "public_key": "eAieVZ089gpOMR1DZM",
      "secret_key": "G4K9NAKaK5GkD9dzZ0",
      "order_id": orderid,
    };
  }
}