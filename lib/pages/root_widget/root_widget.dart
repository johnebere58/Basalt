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
    return Consumer<RootViewModel>(
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
