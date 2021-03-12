import 'package:flutter/material.dart';

class ChooseAvatarWidget extends StatefulWidget {
  final Function? onAvatarAdd;

  const ChooseAvatarWidget({Key? key, required this.onAvatarAdd}) : super(key: key);
  @override
  _ChooseAvatarWidgetState createState() => _ChooseAvatarWidgetState();
}

class _ChooseAvatarWidgetState extends State<ChooseAvatarWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
          child: Container(
        width: 200,
        height: 200,
        
        color: Theme.of(context).appBarTheme.backgroundColor,
      ),
    );
  }
}