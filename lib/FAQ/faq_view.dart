

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzi/FAQ/faq_model.dart';
import 'package:foodzi/FAQ/faq_que_ans.dart';
import 'package:foodzi/Utils/String.dart';

class FAQVIew extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FAQVIewState();
  }
}

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/faq.json');
}

class _FAQVIewState extends State<FAQVIew> {

  List<FaqModelDatum> faqModelTitles = [];
  @override
  void initState() {
    // TODO: implement initState
    loadJson();
    super.initState();
  }

  void loadJson() async{
    var data = await loadAsset();
    var model = FaqModel.fromJson(json.decode(data));
    setState(() {
      faqModelTitles = model.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      appBar: AppBar(
        title: Text("FAQS"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children:faqModelTitles.map((e) => GestureDetector(
              onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => FaqQueAndView(e.data,e.title)));
              },
              child: Card(
                elevation: 3.0,
              child: Padding(padding: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    Text(e.title,
                    style: TextStyle(
                  color: Colors.black,
                  fontFamily: KEY_FONTFAMILY,
                  fontWeight: FontWeight.w600,
                  fontSize: FONTSIZE_15),
                    ),
                    Expanded(child: Container()),
                    Text(">")
                    ],
                ),
              ),
            ),
            )).toList() ,
          ),
        ),
      ) ,
    );
  }
}