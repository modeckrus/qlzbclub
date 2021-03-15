import 'package:flutter/material.dart';

import '../localization/localizations.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).homescreen),

      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.list),
            title: Text(AppLocalizations.of(context).test),
            trailing: Icon(Icons.navigate_next),
            onTap: (){
              Navigator.pushNamed(context, '/test');
            },
          ),
          ListTile(
            leading: Icon(Icons.today_outlined),
            title: Text('Todo'),
            trailing: Icon(Icons.navigate_next),
            onTap: (){
              Navigator.pushNamed(context, '/todo');
            },
          ),
          ListTile(
            leading: Icon(Icons.public),
            title: Text('Club'),
            trailing: Icon(Icons.navigate_next),
            onTap: (){
              Navigator.pushNamed(context, '/club');
            },
          ),
          ListTile(
            leading: Icon(Icons.subscriptions),
            title: Text('ClubList'),
            trailing: Icon(Icons.navigate_next),
            onTap: (){
              Navigator.pushNamed(context, '/clubList');
            },
          ),
        ],
      ),
    ));
  }
}