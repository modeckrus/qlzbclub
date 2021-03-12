import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  final String error;

  const ErrorPage({Key? key, this.error = 'Error'}) : super(key: key);
  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.error, style: TextStyle(
              fontSize: 24,
            ),)
          ],
        ),
      ),
      
    );
  }
}