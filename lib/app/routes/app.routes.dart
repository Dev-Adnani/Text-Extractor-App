import 'package:textscanner/meta/view/homeView/home.view.dart';

class AppRoutes {
  static const String homeRoute = "/home";

  static final routes = {
    homeRoute: (context) => const HomeView(),
  };
}
