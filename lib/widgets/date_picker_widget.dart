import 'package:basalt/basalt.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DatePickerWidget extends StatefulWidget {
  final String title;
  final int? time;
  final Function(int time) onSelected;
  final double height;

  const DatePickerWidget(
      {required this.title,
      required this.onSelected,
      this.height = 55,
        this.time,
      Key? key})
      : super(key: key);

  @override
  State<DatePickerWidget> createState() => DatePickerWidgetState();
}

class DatePickerWidgetState extends State<DatePickerWidget> {

  int? time;

  @override
  void initState() {
    time = widget.time;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: DateTime.now().subtract(const Duration(days: 365)),
          maxTime: DateTime.now(),
          onChanged: (date) {},
          onConfirm: (date) {
            setState(() {
              time = date.millisecondsSinceEpoch;
              widget.onSelected(time!);
              setState(() {});
            });
          },
        );
      },
      child: Container(
        height: widget.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0 ),
        decoration: BoxDecoration(
            border:
            Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(10)),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
             Flexible(
                fit: FlexFit.tight,
                child: Text(
                  time==null?widget.title:TimeUtils.formatTime2(time!),
                  style: 16.asTextStyle(false,color:
                  time==null?Colors.white.withOpacity(.3)
                          : Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),

              15.asWidth,
              Icon(
                  Icons.calendar_month,
                  size: 18,
                  color: Colors.white.withOpacity(.5),
                ),
            ],
          ),
        ),
      ),
    );
  }

}
