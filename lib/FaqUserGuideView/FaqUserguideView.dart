import 'package:flutter/material.dart';
import 'package:foodzi/FAQ/faq_view.dart';
import 'package:foodzi/FaqUserGuideView/UserGuideView.dart';
import 'package:foodzi/Utils/String.dart';

class FaqUserGuideView extends StatefulWidget {
  @override
  _FaqUserGuideViewState createState() => _FaqUserGuideViewState();
}

class _FaqUserGuideViewState extends State<FaqUserGuideView> {
  int _selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "FAQ & User Guide",
          style: TextStyle(
              fontSize: FONTSIZE_18,
              fontFamily: KEY_FONTFAMILY,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
      body: Container(
          child: ListView.builder(
              itemCount: title.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _onSelected(index);
                  },
                  child: Card(
                    elevation: 3.0,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: <Widget>[
                          Text(
                            title[index],
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
                );
              })),
    );
  }

  _onSelected(index) {
    setState(() {
      _selectedMenu = index;
    });

    if (index == 0) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => FAQVIew()));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => UserGuideView()));
    }
  }
}

List<String> title = ["FAQS", "User Guide"];
