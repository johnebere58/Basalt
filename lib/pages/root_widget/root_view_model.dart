import 'package:basalt/basalt.dart';
import 'package:flutter/services.dart';

class RootViewModel extends BaseViewModel {

  Animation<double> getAnimation(AnimationController animationController) {
    return CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
  }
  void startup({required AnimationController animationController}) async {
    Future.delayed(const Duration(seconds: 1), () {
      animationController.forward();
    });

    Future.delayed(const Duration(milliseconds: 1600), () {
      final mySystemTheme = SystemUiOverlayStyle.light
          .copyWith(systemNavigationBarColor: Colors.white);
      SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
      AppRouter.routeToHome(arguments: HomeArguments(message: "Sweetie"));
    });
  }
}
