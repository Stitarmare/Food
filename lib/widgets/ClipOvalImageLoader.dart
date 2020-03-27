import 'package:flutter/material.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:http/http.dart' as http;

class ClipOvalImageWithLoader extends StatefulWidget {
  double height;
  double width;
  double radiusValue;
  String placeholder;
  String url;
  ClipOvalImageWithLoader(this.url,
      {this.placeholder, this.height, this.width, this.radiusValue});
  @override
  State<StatefulWidget> createState() {
    return ClipOvalImageWithLoaderState();
  }
}

class ClipOvalImageWithLoaderState extends State<ClipOvalImageWithLoader> {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: FutureBuilder(
        future: http.get(widget.url ?? STR_BLANK),
        builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Image.asset(
                widget.placeholder ?? STR_BLANK,
                height: widget.height ?? double.infinity,
                width: widget.width ?? double.infinity,
              );
            case ConnectionState.active:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              if (snapshot.hasError)
                return Image.asset(
                  widget.placeholder ?? STR_BLANK,
                  height: widget.height ?? double.infinity,
                  width: widget.width ?? double.infinity,
                );
              return Image.memory(
                snapshot.data.bodyBytes,
                fit: BoxFit.cover,
                height: widget.height ?? double.infinity,
                width: widget.width ?? double.infinity,
              );
          }
          return null;
        },
      ),
    );
  }
}
