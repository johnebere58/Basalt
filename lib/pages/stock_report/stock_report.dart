import 'dart:ui';
import 'package:basalt/basalt.dart';

class StockReport extends StatefulWidget {
  const StockReport({Key? key}) : super(key: key);

  @override
  State<StockReport> createState() => _StockReportState();
}

class _StockReportState extends State<StockReport> {
  StockViewModel? _model;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _model!.setup(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StockViewModel>(builder: (_, model, __) {
      _model ??= model;
      return Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      ImageAssets.stock,
                      fit: BoxFit.cover,
                    ),
                    BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                        child: Container(
                          color: Colors.black.withOpacity(.4),
                        )),
                    model.loadingError != null
                        ? EmptyLayout(
                            Icons.info,
                            "Oops!",
                            "${model.loadingError}",
                            clickText: "Retry",
                            click: () {
                              model.loadItems();
                            },
                            titleColor: Colors.white,
                            textColor: Colors.white,
                          )
                        : model.pageIsLoading
                            ? const LoadingWidget(
                                height: 200,
                                trans: true,
                              )
                            : body()
                  ],
                ),
              ),
            ],
          ));
    });
  }

  Widget body() {
    return Column(
      children: [
        Row(
          children: [
            DatePickerWidget(
              title: "Start Time",
              onSelected: (_) {},
              key: ValueKey("startTime${_model!.startTimeMilli}"),
            ),
            DatePickerWidget(
              title: "Start Time",
              onSelected: (_) {},
              key: ValueKey("startTime${_model!.endTimeMilli}"),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [lineChart()],
            ),
          ),
        ),
      ],
    );
  }

  Widget lineChart() {
    List<ChartDataModel> items = _model!.itemList;
    if (items.isEmpty) {
      return const EmptyLayout(Icons.bar_chart, "No data available", "");
    }

    int minDay = DateTime.parse(items[0].date).millisecondsSinceEpoch;
    int maxDay =
        DateTime.parse(items[items.length - 1].date).millisecondsSinceEpoch;
    int days = (maxDay - minDay) ~/ Duration.millisecondsPerDay;

    double maxY = _model!.maxValue.toDouble();
    double maxX = days.toDouble();

    return SizedBox(
      height: (MediaQuery.of(context).size.height) / 2,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
            handleBuiltInTouches: true,
            touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                getTooltipItems: (_) {
                  return List.generate(_.length, (index) {
                    LineBarSpot item = _[index];
                    int time = (item.x.toInt() * Duration.millisecondsPerDay) +
                        (minDay);
                    String day = TimeUtils.formatTime(time);
                    return LineTooltipItem("${item.y}\n Codes\n$day",
                        12.asTextStyle(false, color: Colors.white));
                  });
                }),
          ),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  interval: (items.length / 8).ceilToDouble(),
                  getTitlesWidget: (double value, TitleMeta meta) {
                    int time = (value.toInt() * Duration.millisecondsPerDay) +
                        (minDay);
                    String day = TimeUtils.formatTime(time);
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 10,
                      child: Text(day,
                          style: 12.asTextStyle(false, color: Colors.white)),
                    );
                  }),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                getTitlesWidget: (double value, TitleMeta meta) {
                  // int count = value.toInt();
                  return Text('${value.toInt()}',
                      style: 12.asTextStyle(false,
                          color: Colors.white.withOpacity(.5)),
                      textAlign: TextAlign.center);
                },
                showTitles: true,
                interval: 5,
                reservedSize: 40,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              bottom: BorderSide(color: Color(0xff4e4965), width: 4),
              left: BorderSide(color: Colors.transparent),
              right: BorderSide(color: Colors.transparent),
              top: BorderSide(color: Colors.transparent),
            ),
          ),
          lineBarsData: List.generate(StockType.values.length, (index) {
            return lineData(StockType.values[index]);
          }),
          minX: 0,
          maxX: maxX,
          maxY: maxY,
          minY: 0,
        ),
        swapAnimationDuration: const Duration(milliseconds: 250),
      ),
    );
  }

  LineChartBarData lineData(StockType type) {
    List<ChartDataModel> items = _model!.itemList;
    int minDay = DateTime.parse(items[0].date).millisecondsSinceEpoch;
    return LineChartBarData(
        isCurved: false,
        color: Colors.white.withOpacity(.5),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: List.generate(items.length, (index) {
          int day = DateTime.parse(items[index].date).millisecondsSinceEpoch;
          int x = (day - minDay) ~/ Duration.millisecondsPerDay;
          int y = (type == StockType.maxClose
                  ? items[index].close
                  : type == StockType.maxOpen
                      ? items[index].open
                      : type == StockType.maxLast
                          ? items[index].last
                          : type == StockType.maxLow
                              ? items[index].low
                              : items[index].high)
              .toInt();
          return FlSpot(x.toDouble(), y.toDouble());
        }));
  }
}
