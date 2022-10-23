import 'package:bimedya/Screens/Login/login_screen.dart';
import 'package:bimedya/Screens/Signup/signup_screen.dart';
import 'package:bimedya/Screens/Welcome/components/background.dart';
import 'package:bimedya/components/rounded_button.dart';
import 'package:bimedya/constants.dart';
import 'package:bimedya/home_page.dart';
import 'package:bimedya/utils/Json.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:platform_device_id/platform_device_id.dart';


class Body extends StatelessWidget {




  @override
  Widget build(BuildContext context) {

    Future<void> signupClicked() async {

      final ProgressDialog pr = ProgressDialog(context);
      await pr.show();
      String deviceId = await PlatformDeviceId.getDeviceId;
      SharedPreferences prefs = await SharedPreferences.getInstance();


      getProfile(deviceId).then((value) => {
        if(value["error"] == null){
          print("profil:"),
          print(value),

          login(deviceId, deviceId).then((value) => {

      if(value["message"]["login"] == "true"){
      prefs.setString("username", deviceId),
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          ),
        )
      }else{
      pr.hide(),
      CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      text: "error",
      )
      }

      })

        }else{
          print(value["error"]["text"]),
      register(deviceId, deviceId, "name", "surname", deviceId).then((value) => {
      if(value["message"]["register"] == "true"){
      prefs.setString("username", deviceId),
      Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) {
      return HomePage();
      },
      ),
      )
      }else{
      pr.hide(),
      CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      text: "Error",
      )

      }

      })
        }

      });





    }


    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: size.height * 0.05),
            Image.asset("assets/images/2.png",height: size.height * 0.45,),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              color: Colors.blue,
              text: "LOGIN WITH PHONE",
              press: () {
                signupClicked();
              },
            ),
            RoundedButton(
              color: Colors.blue,
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: Colors.blue,
              textColor: Colors.white,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
