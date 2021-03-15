import 'package:clubhouse/widgets/cached_image.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatefulWidget {
  final String? avatarUrl;
  final double? width;
  final double? height;
  const AvatarWidget({Key? key, this.avatarUrl, this.height, this.width}) : super(key: key);
  @override
  _AvatarWidgetState createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(50),
          child: Container(
            width: widget.width,
            height: widget.height,
        child: CachedImage(
          url: widget.avatarUrl ??
              'https://firebasestorage.googleapis.com/v0/b/qlzbclubhouse.appspot.com/o/avatar128_128.png?alt=media&token=9a82ada2-0943-4f56-a433-b106bb73862f',
        ),
      ),
    );
  }
}
