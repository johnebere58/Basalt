import 'package:basalt/basalt.dart';

class EmptyLayout extends StatefulWidget {
  final Function()? onClosed;
  final dynamic icon;
  final String title;
  final String text;
  final Function()? click;
  final String clickText;
  final double bottomMargin;
  final double topMargin;
  final bool dontTint;
  final Color? textColor;
  final String pageTitle;
  final Color? titleColor;
  final double backButtonSize;
  const EmptyLayout(this.icon, this.title, this.text,
      {Key? key,
      this.click,
      this.clickText = "Retry",
      this.topMargin = 15,
      this.backButtonSize = 45,
      this.bottomMargin = 40,
      this.pageTitle = "",
      this.titleColor,
      this.dontTint = false,
      this.onClosed,
      this.textColor})
      : super(key: key);
  @override
  EmptyLayoutState createState() => EmptyLayoutState();
}

class EmptyLayoutState extends State<EmptyLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onClosed != null) {
      return SafeArea(
        child: page(),
      );
    }
    return page();
  }

  page() {
    String title = widget.title;
    String text = widget.text;
    return Stack(
      children: [
        Center(
          child: Container(
            // width: double.infinity,
            margin: EdgeInsets.fromLTRB(
                20, widget.topMargin, 20, widget.bottomMargin),
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
                // color: whiteColor3,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (widget.textColor ?? Colors.black).withOpacity(.1)),
                    padding: const EdgeInsets.all(15),
                    child: ImageIconWidget(widget.icon, 40, widget.textColor ?? Colors.black)),
                10.asHeight,
                if (title.isNotEmpty)
                  Text(
                    title,
                    style: 20.asTextStyle(true,
                        color: widget.textColor ?? Colors.black),
                    textAlign: TextAlign.center,
                  ),
                if (text.isNotEmpty && title.isNotEmpty) 15.asHeight,
                if (text.isNotEmpty)
                  Flexible(
                    child: Text(
                      text,
                      style: 14.asTextStyle(false,
                          color: (widget.textColor ?? Colors.black)
                              .withOpacity(.5)),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                if (widget.click != null)
                  Flexible(
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.only(top: 10),
                      child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  25), //side: BorderSide(width: 2,color:black)
                            ),
                            backgroundColor: ColorAssets.appColor,
                            padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                          ),
                          onPressed: widget.click,
                          child: Text(
                            widget.clickText,
                            style: 15.asTextStyle(true, color: Colors.white),
                          )),
                    ),
                  )
              ],
            ),
          ),
        ),
        if (widget.onClosed != null)
          Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: widget.backButtonSize,
                margin: const EdgeInsets.only(left: 0, top: 15, right: 0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: widget.backButtonSize,
                      height: widget.backButtonSize,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: TextButton(
                        onPressed: () {
                          widget.onClosed!();
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          shape: const CircleBorder(),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: widget.titleColor ?? Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                    Flexible(
                        child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.pageTitle,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: widget.titleColor ?? Colors.black),
                      ),
                    )),
                    SizedBox(
                      width: widget.backButtonSize + 20,
                    )
                  ],
                ),
              ))
      ],
    );
  }
}
