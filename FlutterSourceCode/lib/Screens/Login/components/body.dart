import 'package:bimedya/Screens/Login/components/background.dart';
import 'package:bimedya/Screens/Signup/signup_screen.dart';
import 'package:bimedya/components/already_have_an_account_acheck.dart';
import 'package:bimedya/components/rounded_button.dart';
import 'package:bimedya/components/rounded_input_field.dart';
import 'package:bimedya/components/rounded_password_field.dart';
import 'package:bimedya/home_page.dart';
import 'package:bimedya/utils/Json.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLogged = false;
String email;
String pass;

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _Body createState() => _Body();


}

class _Body extends State<Body>{





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLogged = false;
  }

  Future<void> loginClicked() async {
    final ProgressDialog pr = ProgressDialog(context);
    await pr.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    login(email, pass).then((value) => {

      if(value["message"]["login"] == "true"){
        prefs.setString("username", email),
        setState(() {
          pr.hide();
          isLogged = true;
        }),
      }else{
        pr.hide(),
    CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      text: "error",
    )
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLogged ? HomePage() : Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: size.height * 0.03),
            Image.asset("assets/images/2.png",height: size.height * 0.45,),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Username",
              onChanged: (value) {email = value;},
            ),
            RoundedPasswordField(
              onChanged: (value) {pass = value;},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                loginClicked();
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
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


