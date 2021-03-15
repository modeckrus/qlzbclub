import 'package:flutter/material.dart';

class CachedImage extends StatefulWidget {
  final String url;
  final double? widgth;
  final double? height;
  const CachedImage({Key? key, required this.url, this.height, this.widgth}) : super(key: key);
  @override
  _CachedImageState createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.widgth,
      height: widget.height,
      child: Image.network(widget.url),
    );
  }
}