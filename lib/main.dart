// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

import 'package:clubhouse/pages/home_page.dart';
import 'package:clubhouse/pages/login/login_page.dart';
import 'package:clubhouse/service/path_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path_provider/path_provider.dart';

import 'authentication/bloc/authentication_bloc.dart';
import 'dark_theme.dart';
import 'dependecies.dart';
import 'localization/lang_codes.dart';
import 'localization/localizations.dart';
import 'pages/setupuser/setup_user_page.dart';
import 'pages/verify_email.dart';
import 'route_generator.dart';
import 'service/dgraph_service.dart';
import 'service/user_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<int> appinit() async {
    try {
      // await Firebase.initializeApp();
      // final auth = FirebaseAuth.instance;
      // final UserRepository userRepository = UserRepository(
      //   firebaseAuth: auth,
      //   googleSignin: GoogleSignIn(),
      // );
      await PathService.init();
      Hive.init(PathService.hiveDir);

      await Dependencies.init();

      setState(() {
        loading = !loading;
      });
      return 1;
      // Navigator.pushNamed(context, '/');
    } catch (e) {
      print(e);
      final dir = Directory(PathService.hiveDir??PathService.defaultPath);
      dir.deleteSync(recursive: true);
      appinit();
      return 0;
    }
  }
  bool loading = true;
  @override
  void initState() {
    appinit();
    super.initState();
  }

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            alignment: Alignment.center,
            child: Container(
                width: 50, height: 50, child: CircularProgressIndicator()),
          )
        : BlocProvider(
            create: (context) => AuthenticationBloc(),
            child: MaterialApp(
              navigatorKey: _navigatorKey,
              localizationsDelegates: [
                AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: LangCodes.locales,
              onGenerateTitle: (BuildContext context) {
                Jiffy.locale(Localizations.localeOf(context).languageCode)
                    .then((value) {
                  print('Jiffy locale setted: ' + value);
                });
                return AppLocalizations.of(context).title;
              },
              themeMode: ThemeMode.dark,
              // themeMode: ThemeMode.dark,
              darkTheme: MyDartTheme.darkTheme,
              onGenerateRoute: (settings) {
                return RouteGenerator.onGenerateRouter(
                    settings);
              },

              initialRoute: '/',
              home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                if (state.status == AuthenticationStatus.unknown) {
                  print('Unknow state');
                  return Container(
                    alignment: Alignment.center,
                    child: Container(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator()),
                  );
                }
                if(state.status == AuthenticationStatus.unsetted){
                  return SetupUserPage();
                }
                if(state.status == AuthenticationStatus.unverified){
                  return VerifyEmailPage();
                }
                if(state.status == AuthenticationStatus.unauthenticated){
                  return LoginPage();
                }
                if(state.status == AuthenticationStatus.authenticated){
                  return HomePage();
                }
                print('Unknow Auth status');
                return LoginPage();
              }),
            ),
          );
  }
}
