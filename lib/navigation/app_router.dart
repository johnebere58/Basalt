import 'package:basalt/basalt.dart';

class AppRouter{

  static GlobalKey<NavigatorState> appNavigatorKey =
  GlobalKey<NavigatorState>();

  static void routeToHome({Object? arguments}){
    appNavigatorKey.currentState!.pushNamed(AppRoutes.home,arguments: arguments);
  }

  static void routeTo(String routeName,{Object? arguments}){
    appNavigatorKey.currentState!.pushNamed(routeName,arguments: arguments);
  }

}