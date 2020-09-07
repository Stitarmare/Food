import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzi/FAQ/faq_model.dart';
import 'package:foodzi/FAQ/faq_que_ans.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/theme/colors.dart';

class FAQVIew extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FAQVIewState();
  }
}

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/faq.json');
}

class _FAQVIewState extends State<FAQVIew> {
  List<FaqModelDatum> faqModelTitles = [];
  int _selectedMenu;

  @override
  void initState() {
    loadJson();
    super.initState();
  }

  void loadJson() async {
    var data = await loadAsset();
    var model = FaqModel.fromJson(json.decode(data));
    setState(() {
      faqModelTitles = model.data;
    });
  }

  _onSelected(index) {
    setState(() {
      _selectedMenu = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "FAQS",
          style: TextStyle(
              fontSize: FONTSIZE_18,
              fontFamily: KEY_FONTFAMILY,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
            child:
                // Column(
                //   children: faqModelTitles
                //       .map((e) => GestureDetector(
                //             onTap: () {
                //               Navigator.of(context).push(MaterialPageRoute(
                //                   builder: (context) =>
                //                       FaqQueAndView(e.data, e.title)));
                //             },
                //             child: Card(
                //               elevation: 3.0,
                //               child: Padding(
                //                 padding: EdgeInsets.all(15),
                //                 child: Row(
                //                   children: <Widget>[
                //                     Text(
                //                       e.title,
                //                       style: TextStyle(
                //                           color: Colors.black,
                //                           fontFamily: KEY_FONTFAMILY,
                //                           fontWeight: FontWeight.w600,
                //                           fontSize: FONTSIZE_15),
                //                     ),
                //                     Expanded(child: Container()),
                //                     Text(">")
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ))
                //       .toList(),
                // ),
                Column(
                    children: faqModelTitles
                        .asMap()
                        .map((index, e) => MapEntry(
                            index,
                            GestureDetector(
                              onTap: () {
                                _onSelected(index);

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        FaqQueAndView(e.data, e.title)));
                              },
                              child: Card(
                                elevation: 3.0,
                                color: _selectedMenu != null &&
                                        _selectedMenu == index
                                    ? greytheme100
                                    : Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        e.title,
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
                            )))
                        .values
                        .toList())),
      ),
    );
  }
}
