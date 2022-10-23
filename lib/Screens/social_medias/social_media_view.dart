
import 'package:bimedya/main.dart';
import 'package:bimedya/models/CategoryModel.dart';
import 'package:bimedya/order_details.dart';
import 'package:bimedya/utils/Json.dart';
import 'package:bimedya/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../packages_detail.dart';


// ignore: must_be_immutable
class SocialMediaViewPage extends StatefulWidget {
  @override
  _SocialMediaViewPageState createState() =>
      _SocialMediaViewPageState(name: name, imgurl: imgurl, jsonurl: jsonurl);

  String name;
  String imgurl;
  String jsonurl;

  SocialMediaViewPage(
      {@required this.name, @required this.imgurl, @required this.jsonurl});
}

class _SocialMediaViewPageState extends State<SocialMediaViewPage> {
  String name;
  String imgurl;
  String jsonurl;

  _SocialMediaViewPageState({this.name, this.imgurl, this.jsonurl});

  List<CategoryModel> _notes = List<CategoryModel>();

  @override
  void initState() {
    print("jsonasdasddata");
    print(jsonurl);

    getCategories(jsonurl.toString(),devicelanguage).then((value) => {
          setState(() {
            _notes = value;
          }),
        });

    /*
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
      });
    });

     */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
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
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 1),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(15.0),
                height: 60.0,
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
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              height: 40.0,
                              child: Image.network(widget.imgurl),
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              widget.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: _buildListViewSocialMedia(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deneme(int index) async {
    final ProgressDialog pr = ProgressDialog(context);
    await pr.show();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PackageDetail(
          category: _notes[index].name,
          catid: _notes[index].catid,
        ),
      ),
    ).then((value) => {
      pr.hide()
    });
  }

  Widget _buildListViewSocialMedia() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: _notes.length,
      itemBuilder: (context, index) {
        return InkWell(child: Container(

          decoration: BoxDecoration(
            color: index % 2 == 0 ? Colors.white : Colors.lightBlueAccent,
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
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          margin: EdgeInsets.all(10),
          child: Column(

            children: [
              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              deneme(index);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: Text(
                                "${_notes[index].name}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),onTap: (){deneme(index);},);
      },
    );
  }
}
