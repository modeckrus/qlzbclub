// import 'dart:js';

import 'package:clubhouse/pages/club_list_page.dart';
import 'package:clubhouse/pages/club_page.dart';
import 'package:clubhouse/pages/todo_page.dart';
import 'package:flutter/widgets.dart';

import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/test_page.dart';
import 'transition_route.dart';


class RouteGenerator {
  static Route<dynamic> onGenerateRouter(
      RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return PageRouteTransition(builder: (context) {
          return HomePage();
        });
        break;
      case '/test':
        return PageRouteTransition(builder: (context) {
          return TestPage();
        });
        break;
      case '/editProfile':
      return PageRouteTransition(
            builder: (_) => ProfilePage(),
            animationType: AnimationType.slide_right,
            curves: Curves.easeInOut);
      case '/todo':
      return PageRouteTransition(
            builder: (_) => const TodoPage(),
            animationType: AnimationType.slide_right,
            curves: Curves.easeInOut);
      case '/club':
      return PageRouteTransition(
            builder: (_) => const ClubPage(),
            animationType: AnimationType.slide_right,
            curves: Curves.easeInOut);
      case '/clubList':
      return PageRouteTransition(
            builder: (_) => const ClubListPage(),
            animationType: AnimationType.slide_right,
            curves: Curves.easeInOut);
      // case '/login':
      //   return PageRouteTransition(builder: (context) {
      //     return LoginPage();
      //   });
      //   break;
      default:
        return PageRouteTransition(builder: (context) {
          return TestPage();
        });
    }
  }
}
