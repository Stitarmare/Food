import 'package:flutter/material.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:http/http.dart' as http;

class ImageWithLoader extends StatefulWidget {
  double height;
  double width;
  double radiusValue;
  String placeholder;
  String url;
  BoxFit fit;
  ImageWithLoader(this.url,
      {this.placeholder, this.height, this.width, this.radiusValue, this.fit});
  @override
  State<StatefulWidget> createState() {
    return ImageWithLoaderState();
  }
}

class ImageWithLoaderState extends State<ImageWithLoader> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(widget.radiusValue ?? 0),
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
              return Container(
                  child: Center(child: CircularProgressIndicator()));
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
