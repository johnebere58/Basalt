import 'package:basalt/basalt.dart';
import 'package:flutter/cupertino.dart';

class RouteBuilder{

  static Route build(
      RouteSettings settings,
      Widget screen, {
        bool isFullScreen = false,
        Duration transitionDuration =
        const Duration(milliseconds: 300),
        RouteTransitionsBuilder? transition,
      }) {
    if (Platform.isIOS) {
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => screen,
        fullscreenDialog: isFullScreen,
      );
    }
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secAnimation) => screen,
      fullscreenDialog: isFullScreen,
      transitionsBuilder: transition??TransitionUtils.scaleTransition,
      transitionDuration: transitionDuration,
    );
  }
}