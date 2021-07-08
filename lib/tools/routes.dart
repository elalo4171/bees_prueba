import 'package:bees_prueba/page/book_page.dart';
import 'package:bees_prueba/page/home_page.dart';
import 'package:bees_prueba/page/search_page.dart';
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
        case "book":
          route = MaterialPageRoute(
            builder: (_) => BookPage(settings.arguments),
            settings: RouteSettings(name: settings.name),
          );
          break;
        case "search":
          route = MaterialPageRoute(
            builder: (_) => SearchPage(),
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
