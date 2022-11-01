import 'package:basalt/basalt.dart';

class AppRoutes {
  static const String home = "/home";
  static const String stock = "/stock";

  static Route getRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return RouteBuilder.build(settings, const HomePage(),transition: TransitionUtils.fadeTransition);
      case stock:
        return RouteBuilder.build(settings, const StockReport(),transition: TransitionUtils.scaleTransition);
      default:
        return RouteBuilder.build(settings, const RootWidget());
    }
  }

}
