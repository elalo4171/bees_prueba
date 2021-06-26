import 'package:bees_prueba/page/home_page.dart';
import 'package:bees_prueba/page/splash_page.dart';
import 'package:flutter/material.dart';

Route Function(RouteSettings) get routes => (RouteSettings settings) {
      Route route;

      switch (settings.name) {
        case "home":
          route = MaterialPageRoute(
            builder: (_) => HomePage(),
            settings: RouteSettings(name: settings.name),
          );
          break;
        default:
          route = MaterialPageRoute(
            builder: (_) => SplashPage(),
            settings: RouteSettings(name: settings.name),
          );
          break;
      }

      return route;
    };
