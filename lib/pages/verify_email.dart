import '../localization/localizations.dart';
import '../service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';

class VerifyEmailPage extends StatefulWidget {
  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).verifyEmail),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: (){
              GetIt.I.get<UserService>().logOut();
            },
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Text(AppLocalizations.of(context).instructionVerifyEmail, style: TextStyle(fontSize: 24),),

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
                        child: RawMaterialButton(
                mouseCursor: SystemMouseCursors.click,
                fillColor: Theme.of(context).appBarTheme.backgroundColor,
                focusColor: Theme.of(context).accentColor,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(AppLocalizations.of(context).verifyEmail, style: TextStyle(
                    fontSize: 20
                  ),),
                ),
                onPressed: (){
                GetIt.I.get<UserService>().checkEmailVerification();
              }),
            )),
          )
        ],
      ),
    ));
  }
}