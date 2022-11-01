import 'package:basalt/basalt.dart';

class LoadingWidget extends StatelessWidget {
  final bool trans;
  final double? height;
  final double backButtonSize;
  final bool fullPage;
  final Function()? onClosed;
  final Color? color;
  final Color backColor;
  final Color titleColor;
  final String pageTitle;
  final double bottom;
  const LoadingWidget(
      {this.trans = false,
      this.height,
      this.backButtonSize = 45,
      this.fullPage = false,
      this.onClosed,
      this.color,
      this.backColor = Colors.white,
      this.titleColor = Colors.black,
      this.pageTitle = "",
      this.bottom = 0,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Center(child: customLoading(color: color, size: 40));
    return Container(
      color: trans ? Colors.transparent : backColor,
      child: fullPage
          ? SafeArea(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  child,
                  if (onClosed != null)
                    Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: backButtonSize,
                          margin: const EdgeInsets.only(top: 15),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: backButtonSize,
                                height: backButtonSize,
                                margin:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: TextButton(
                                  onPressed: () {
                                    onClosed!();
                                  },
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(0),
                                    shape: const CircleBorder(),
                                  ),
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: titleColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Flexible(
                                  child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  pageTitle,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: titleColor),
                                ),
                              )),
                              SizedBox(
                                width: backButtonSize + 20,
                              )
                            ],
                          ),
                        ))
                ],
              ),
            )
          : Center(
            child: Container(
                width: double.infinity,
                height: height,
                margin: const EdgeInsets.only(bottom: 50),
                child: child,
              ),
          ),
    );
  }

  Widget customLoading(
      {Color? color,
      double size = 15,
      bool loading = true,
      double topMargin = 0,
      double bottomMargin = 0,
      String text="Please Wait"}) {
    color ??= ColorAssets.appColor;
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2)),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(color.withOpacity(.7)),
                strokeWidth: 4,
              )),
            Card(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.only(top: 15),
              elevation: 5,
              color: Colors.white.withOpacity(.1),
              shadowColor: Colors.black.withOpacity(.2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                      color: Colors.black.withOpacity(.05), width: .5)),
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Text(text,
                    style: 12.asTextStyle(true,
                        color: Colors.white.withOpacity(.5))),
              ),
            )
        ],
      ),
    );
  }
}
