import 'package:bimedya/Screens/Login/login_screen.dart';
import 'package:bimedya/Screens/Signup/components/background.dart';
import 'package:bimedya/components/already_have_an_account_acheck.dart';
import 'package:bimedya/components/rounded_button.dart';
import 'package:bimedya/components/rounded_input_field.dart';
import 'package:bimedya/components/rounded_password_field.dart';
import 'package:bimedya/home_page.dart';
import 'package:bimedya/utils/Json.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';




String email = "";
String pass = "";
String name = "";
String surname = "";
bool isLogged = false;

class Body extends StatefulWidget {
  @override
  _Body createState() => _Body();
  Body();

}

class _Body extends State<Body>{


  Future<void> signup(String email,String pass) async {
    final ProgressDialog pr = ProgressDialog(context);
    await pr.show();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      setState(() {
        isLogged = true;
        pr.hide();
      });



    }  catch (e) {
      print(e.toString());
      pr.hide().then((value) => {
      CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      text: e.toString(),
      )
      });



      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLogged = false;
  }

  Future<void> signupClicked() async {
    final ProgressDialog pr = ProgressDialog(context);
    await pr.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    register(email, pass, name, surname, email).then((value) => {
     if(value["message"]["register"] == "true"){
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
      text: "Error",
    )

     }

    });


  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("islogged");
    print(isLogged);
    return isLogged ? HomePage() : Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: size.height * 0.08),


            Image.asset("assets/images/person.png",height: 150,width: 150),
            RoundedInputField(
              hintText: "Name",
              onChanged: (value) {name = value;},
            ),
            RoundedInputField(
              hintText: "Surname",
              onChanged: (value) {surname = value;},
            ),
            RoundedInputField(
              hintText: "Username",
              onChanged: (value) {email = value;},
            ),
            RoundedPasswordField(
              onChanged: (value) {pass = value;},
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                signupClicked();

              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
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


          ],
        ),
      ),
    );
  }

}

