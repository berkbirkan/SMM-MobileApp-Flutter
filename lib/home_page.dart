
import 'package:bimedya/Screens/Profile/profile.dart';
import 'package:bimedya/Screens/Welcome/welcome_screen.dart';
import 'package:bimedya/Screens/buy_credit.dart';
import 'package:bimedya/admin_views/admin_main_view.dart';
import 'package:bimedya/config.dart';
import 'package:bimedya/main.dart';
import 'package:bimedya/order_details.dart';
import 'package:bimedya/utils/Json.dart';
import 'package:bimedya/utils/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/social_medias/social_media_view.dart';
import 'models/MediasModel.dart';
import 'models/package_model.dart';

List<Package> serviceslist = [];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

bool isLogged = true;
bool isAdmin = false;

class _HomePageState extends State<HomePage> {
  List<MediasModel> _medias = List<MediasModel>();

  Future<void> ebeninki() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("USERNAME::");
    print(prefs.getString("username"));

  }

  @override
  void initState() {
    getMedias(devicelanguage).then((value) => {
          setState(() {
            _medias = value;
          }),
        });

    super.initState();
    //checkAdmin();
    ebeninki();

  }
/*
  void checkAdmin() {
    FirebaseAuth.instance.onAuthStateChanged.listen((FirebaseUser user) {
      if (user.email == adminEmail) {
        setState(() {
          isAdmin = true;
        });
      }
    });
  }


 */
  void signOut() {
    FirebaseAuth.instance.signOut().then((value) => {
          FirebaseAuth.instance.onAuthStateChanged.listen((FirebaseUser user) {
            if (user == null) {
              print('User is currently signed out!');
              setState(() {
                isLogged = false;
              });
            } else {
              print('User is signed in!');
              setState(() {
                isLogged = true;
              });
            }
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return !isLogged
        ? WelcomeScreen()
        : Scaffold(
            body: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appname,
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
                Container(
                  margin:
                      EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
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
                                  "589.289",
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
                                      child: Icon(Icons.people),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      "USER",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "11",
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
                                      child: Icon(Icons.remove_from_queue),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      "PLATFORM",
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
                      ),
                      Container(
                        child: Image.asset(
                          "assets/images/home1.jpg",
                          height: 150,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 150.0,
                        child: Image.asset(
                          "assets/images/home2.jpg",
                          height: 50,
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "BUY CREDIT",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "BUY CREDITS",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ],
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
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>BuyCredit()));
                                },
                                color: Colors.white,
                                textColor: Colors.white,
                                child: Text("BUY NOW".toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14, color: primaryColor)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 1.0,
                  color: Colors.black.withOpacity(0.1),
                  margin: EdgeInsets.only(top: 25.0),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _medias.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SocialMediaViewPage(
                                name: _medias[index].name,
                                imgurl: _medias[index].url,
                                jsonurl: _medias[index].id,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.all(10),
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Image.network(
                                  _medias[index].url,
                                  height: 50,
                                ),
                              ),
                              Container(
                                width: 100,
                                child: Text(
                                  _medias[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
