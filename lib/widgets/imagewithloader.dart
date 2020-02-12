import 'package:flutter/material.dart';
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
    // TODO: implement createState
    return ImageWithLoaderState();
  }
}

class ImageWithLoaderState extends State<ImageWithLoader> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(widget.radiusValue ?? 0),
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
              return Container(
                  child: Center(child: CircularProgressIndicator()));
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
