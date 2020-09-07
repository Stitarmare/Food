import 'package:flutter/material.dart';
import 'package:foodzi/FAQ/faq_model.dart';
import 'package:foodzi/Utils/String.dart';

class FaqQueAndView extends StatefulWidget {
  List<DatumDatum> dataList;
  String title;
  FaqQueAndView(this.dataList, this.title);
  @override
  State<StatefulWidget> createState() {
    return FaqQueAndViewState();
  }
}

class FaqQueAndViewState extends State<FaqQueAndView> {
  List<DatumDatum> dataList = [];

  @override
  void initState() {
    dataList = widget.dataList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.title,
          style: TextStyle(
              fontFamily: KEY_FONTFAMILY,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: dataList
              .map((e) => Card(
                    elevation: 3.0,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(),
                          Text(
                            "Q: ${e.que}",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: KEY_FONTFAMILY,
                                fontWeight: FontWeight.w600,
                                fontSize: FONTSIZE_15),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "A: ${e.ans}",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: KEY_FONTFAMILY,
                                fontWeight: FontWeight.w200,
                                fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
