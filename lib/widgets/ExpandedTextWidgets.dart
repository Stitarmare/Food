import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.data, {
    Key key,
    this.style,
  }) : super(key: key);

  final String data;
  final TextStyle style;

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;
  static const defaultLines = 2;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      final span = TextSpan(text: widget.data, style: widget.style);
      final tp = TextPainter(
          text: span, textDirection: TextDirection.ltr, maxLines: defaultLines);
      tp.layout(maxWidth: size.maxWidth);

      if (tp.didExceedMaxLines) {
        return Column(
          children: <Widget>[
            new Text(
              widget.data,
              style: widget.style,
              maxLines: _isExpanded ? null : defaultLines,
            ),
            Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 0.5,
                child: InkWell(
                  onTap: _handleOnTap,
                  child: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey.withOpacity(0.6),
                  ),
                ))
          ],
        );
      } else {
        return Text(widget.data, style: widget.style);
      }
    });
  }

  void _handleOnTap() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
}
