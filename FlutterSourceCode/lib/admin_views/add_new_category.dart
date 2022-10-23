import 'package:bimedya/order_details.dart';
import 'package:bimedya/utils/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AddNewCategoryPage extends StatefulWidget {
  @override
  _AddNewServicePageState createState() => _AddNewServicePageState();
}

class _AddNewServicePageState extends State<AddNewCategoryPage> {
  String _value;
  String categoryname;
  List<DropdownMenuItem<String>> medialist = [];
  List<String> mediaids = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMedias();
  }
  


  Future<void> getMedias() async {
    List<DropdownMenuItem<String>> dmedialist = [];
    List<String> dmediaids = [];
    CollectionReference medias = Firestore.instance.collection("medias");
    int i = 0;
    await medias.getDocuments().then((medias) => {

      for(var deneme in medias.documents){
        print(deneme["link"]),
        print(deneme["name"]),
        print("deneme"),

        dmedialist.add(DropdownMenuItem<String>(child: Text(deneme["name"]),value: i.toString())),
        dmediaids.add(deneme.documentID),
        i++

        
      }

    });

    setState(() {
      print("uçak");
      medialist = dmedialist;
      mediaids = dmediaids;
    });
  }

  void addCategory(){
    CollectionReference medias = Firestore.instance.collection("medias");


    medias.add({
      "name": categoryname,


    }).then((value) => {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Successfully added!"),

    })
        .catchError((error) => {
      print("Failed to add user: $error"),
      CoolAlert.show(context: context, type: CoolAlertType.error,text: error.toString()),
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add New Category"),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "ADD NEW CATEGORY",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 150.0,
                        child: Lottie.asset('assets/pay.json'),
                      )
                    ],
                  ),
                ),
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
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Socila Media : "),
                            Center(
                              child: DropdownButton<String>(
                                dropdownColor: Colors.white,
                                items: medialist,
                                onChanged: (String value) {
                                  setState(() {
                                    _value = value;
                                  });
                                },
                                hint: Text('Select Socıal Medıa'),
                                value: _value,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        onChanged: (text) {
                          //link = text;
                          categoryname = text;
                        },
                        cursorColor: Theme.of(context).cursorColor,
                        //  initialValue: 'Input text',
                        maxLength: 50,
                        decoration: InputDecoration(
                          icon: Icon(Icons.supervised_user_circle),
                          labelText: 'Category Name',
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
                      ),
                      InkWell(
                        onTap: () => {
                          // print(amount),
                          //deneme(amount, link),
                          getMedias()
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
                            "ADD",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
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


