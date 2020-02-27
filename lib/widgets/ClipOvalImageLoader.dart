import 'package:flutter/material.dart';
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
    // TODO: implement createState
    return ClipOvalImageWithLoaderState();
  }
}

class ClipOvalImageWithLoaderState extends State<ClipOvalImageWithLoader> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipOval(
      child: FutureBuilder(
        // Paste your image URL inside the htt.get method as a parameter
        future: http.get(widget.url ?? ""),
        builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Image.asset(
                widget.placeholder ?? "",
                height: widget.height ?? double.infinity,
                width: widget.width ?? double.infinity,
              );
            case ConnectionState.active:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              if (snapshot.hasError)
                return Image.asset(
                  widget.placeholder ?? "",
                  height: widget.height ?? double.infinity,
                  width: widget.width ?? double.infinity,
                );
              // when we get the data from the http call, we give the bodyBytes to Image.memory for showing the image
              return Image.memory(
                snapshot.data.bodyBytes,
                fit: BoxFit.cover,
                height: widget.height ?? double.infinity,
                width: widget.width ?? double.infinity,
              );
          }
          return null; // unreachable
        },
      ),
    );
  }
}