import 'package:bimedya/admin_views/add_new_category.dart';
import 'package:bimedya/admin_views/add_new_service.dart';
import 'package:bimedya/admin_views/add_new_socail_media.dart';
import 'package:bimedya/home_page.dart';
import 'package:bimedya/order_details.dart';
import 'package:bimedya/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lottie/lottie.dart';

final List adds = [
  {
    'icon': Icons.whatshot,
    'color': primaryColor,
    'title': "Earn Credit",
    'subtitle': "Whatch Ads and Earn Credit",
  },
  {
    'icon': Icons.whatshot,
    'color': primaryColor,
    'title': "Earn Credit",
    'subtitle': "Whatch Ads and Earn Credit",
  },
  {
    'icon': Icons.whatshot,
    'color': primaryColor,
    'title': "Earn Credit",
    'subtitle': "Whatch Ads and Earn Credit",
  },
  {
    'icon': Icons.whatshot,
    'color': primaryColor,
    'title': "Earn Credit",
    'subtitle': "Whatch Ads and Earn Credit",
  },
];

class AdminPanelViewPage extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<AdminPanelViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADMIN PANEL"),
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
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            color: Colors.white),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Hero(
              tag: "herotag",
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: primaryColor,
                  child: Material(
                    color: Colors.white,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: Image.network("https://www.kindpng.com/picc/b/22/223910.png"),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            color: primaryColor,
                            child: IconButton(
                                alignment: Alignment.center,
                                icon: Icon(
                                  Icons.camera,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                onPressed: () {}),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Text(
              "Ali Demircan",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 30),
            ),
            Text(
              "ADMIN",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 20),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 0),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.w500),
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
                                      color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "8",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.w500),
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
                                      color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Lottie.asset('assets/social.json'),
                  )
                ],
              ),
            ),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100.0,
                    child: Lottie.asset('assets/addnew2.json'),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "ADD",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "NEW SOCIAL MEDIA",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w300),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddNewSocialMediaPage(),
                                  ));
                            },
                            color: Colors.white,
                            textColor: Colors.white,
                            child: Text("ADD".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14, color: primaryColor)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "ADD",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "NEW CATEGORY",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w300),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddNewCategoryPage(),
                                  ));
                            },
                            color: Colors.white,
                            textColor: Colors.white,
                            child: Text("ADD".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14, color: primaryColor)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 150.0,
                    child: Lottie.asset('assets/addnew.json'),
                  ),
                ],
              ),
            ),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 150.0,
                    child: Lottie.asset('assets/addnew3.json'),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "ADD",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "NEW SERVICE",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w300),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddNewServicePage(),
                                  ));
                            },
                            color: Colors.white,
                            textColor: Colors.white,
                            child: Text("ADD".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14, color: primaryColor)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        height: 100,
                        width: MediaQuery.of(context).size.width * .85,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Swiper(
                            key: UniqueKey(),
                            autoplay: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index2) {
                              return Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      adds[index2]["icon"],
                                      color: adds[index2]["color"],
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      adds[index2]["title"],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  adds[index2]["subtitle"],
                                  textAlign: TextAlign.center,
                                ),
                              ]);
                            },
                            itemCount: adds.length,
                            pagination: new SwiperPagination(
                                alignment: Alignment.bottomCenter,
                                builder: DotSwiperPaginationBuilder(
                                    activeSize: 10, color: primaryColor, activeColor: primaryColor)),
                            control: new SwiperControl(
                              size: 20,
                              color: primaryColor,
                              disableColor: primaryColor,
                            ),
                            loop: false,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          primaryColor.withOpacity(.5),
                          primaryColor.withOpacity(.8),
                          primaryColor,
                          primaryColor
                        ],
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * .065,
                    width: MediaQuery.of(context).size.width * .75,
                    child: Center(
                        child: Text(
                      "EXIT",
                      style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
                    ))),
                onTap: () async {},
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color = primaryColor.withOpacity(.4);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1.5;

    var startPoint = Offset(0, -size.height / 2);
    var controlPoint1 = Offset(size.width / 4, size.height / 3);
    var controlPoint2 = Offset(3 * size.width / 4, size.height / 3);
    var endPoint = Offset(size.width, -size.height / 2);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(
        controlPoint1.dx, controlPoint1.dy, controlPoint2.dx, controlPoint2.dy, endPoint.dx, endPoint.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
