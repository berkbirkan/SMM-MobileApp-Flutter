import 'package:bimedya/paymentsettings.dart';
import 'package:bimedya/utils/Json.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'home_page.dart';
import 'package:devicelocale/devicelocale.dart';

bool isActive = false;
bool isLoading = true;
bool ifLogged = false;
bool iswebview = true;
String devicelanguage = "en";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InAppPurchaseConnection.enablePendingPurchases();

  getPaymentinit();

  getDeviceLang().then((value) => {
    devicelanguage = value.split("_")[0],
    print("device LANGUAGE : " + devicelanguage),
    getProfile("iswebview").then((value) => {
      if (value["user_name"] == null)
        {
          runApp(Booster()),
        }
      else
        {
          runApp(MyApp()),
        }
    })
  });
}

Future<void> getPaymentinit() async {
  var paymentde = await getPayments();
  paymenttype = paymentde["payment_type"] ?? "1";
  stripepublishkey = paymentde["stripe_publishable_key"] ?? "";
  stripesecretkey = paymentde["stripe_secret_key"] ?? "";
  stripelanguage = paymentde["stripe_language"] ?? "";
  stripesuccessurl = paymentde["stripe_success_url"] ?? "";
  stripefailurl = paymentde["stripe_fail_url"] ?? "";
  stripeactive = paymentde["stripe_active"] ?? "";
  paytrmerchantid = paymentde["paytr_merchant_id"] ?? "";
  paytrmerchantkey = paymentde["paytr_merchant_key"] ?? "";
  paytrmerchantsalt = paymentde["paytr_merchant_salt"] ?? "";
  paytrlang = paymentde["paytr_language"] ?? "";
  paytrsuccessurl = paymentde["paytr_success_url"] ?? "";
  paytrfailurl = paymentde["paytr_fail_url"] ?? "";
  paytractive = paymentde["paytr_active"] ?? "";
  paypalemail = paymentde["paypay_email"] ?? "";
  paypalclientid = paymentde["paypal_client_id"] ?? "";
  paypalsecretid = paymentde["paypal_secret_id"] ?? "";
  paypalactive = paymentde["paypal_active"] ?? "";
  iapactive = paymentde["iap_active"] ?? "1";

  print("payment type: " + paymenttype);
  print("stripe publish key : " + stripepublishkey);
  print("stripe secret key: " + stripesecretkey);
  print("iap active : " + iapactive);
}

Future<String> getDeviceLang() async {
  String locale = await Devicelocale.currentLocale;
  return locale;
}
/*
Future<void> setOnesignal() async {
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.init(onesignalappid,
      iOSSettings: {OSiOSSettings.autoPrompt: false, OSiOSSettings.inAppLaunchUrl: false});
  OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  await OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);
}*/

class Booster extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
      statusBarColor: Colors.blueAccent, // status bar color
    ));

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'bimedya',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: WebView(initialUrl: "https://tiktok.phpstatistics.com/demo/"));
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
      statusBarColor: Colors.blueAccent, // status bar color
    ));

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'bimedya',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Root());
  }
}

class Root extends StatefulWidget {
  @override
  _Root createState() => _Root();
  Root();
}

class _Root extends State<Root> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ifLogged ? HomePage() : WelcomeScreen();
    //return MaterialApp(home: isLoading ? Scaffold(body: Container(child: Center(child: CircularProgressIndicator() ) ,),): (ifLogged ? HomePage() : WelcomeScreen()) );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkLogged();
    checkifLogged();
  }

  Future<void> checkifLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("deneme: usernname : ");
    print(prefs.getString("username"));
    if (prefs.getString("username") == null) {
      setState(() {
        ifLogged = false;
        isLoading = false;
      });
    } else {
      setState(() {
        ifLogged = true;
        isLoading = false;
      });
    }
  }

  void checkLogged() {
    FirebaseAuth.instance.onAuthStateChanged.listen((FirebaseUser user) {
      if (user == null) {
        print('User is currently signed out!');
        setState(() {
          ifLogged = false;
          isLoading = false;
        });
      } else {
        print('User is signed in!');
        setState(() {
          ifLogged = true;
          isLoading = false;
        });
      }
    });
  }
}