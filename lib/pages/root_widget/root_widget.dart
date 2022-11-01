import 'dart:ui';

import 'package:basalt/basalt.dart';

class RootWidget extends StatefulWidget {
  const RootWidget({Key? key}) : super(key: key);

  @override
  RootWidgetState createState() => RootWidgetState();
}

class RootWidgetState extends State<RootWidget> with TickerProviderStateMixin {
  RootViewModel? _model;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _model?.startup(animationController: animationController);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        exit(0);
      },
      child: Consumer<RootViewModel>(
        builder: (_, model, __) {
          _model ??= model;
          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  ImageAssets.background,
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    ImageAssets.launchImage,
                    width: 150,
                    height: 150,
                  ),
                ),
                CircularRevealAnimation(
                  animation: _model!.getAnimation(animationController),
                  child: Container(
                    color: Colors.white,
                    child: Stack(fit: StackFit.expand,
                      children: [
                        Image.asset(ImageAssets.stock,fit: BoxFit.cover,),
                        ClipRect(
                          child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                              child: Container(
                                color: Colors.black.withOpacity(.4),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
