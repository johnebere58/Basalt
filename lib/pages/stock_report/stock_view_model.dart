import 'package:basalt/basalt.dart';


class StockViewModel extends BaseViewModel{

  BuildContext? _context;
  int startTimeMilli = DateTime.now().subtract(const Duration(days: 60)).millisecondsSinceEpoch;
  int endTimeMilli = DateTime.now().millisecondsSinceEpoch;
  List allItemList = [];
  List<ChartDataModel> itemList = [];
  double maxValue = 0;
  double maxOpen = 0;
  double maxHigh = 0;
  double maxLow = 0;
  double maxLast = 0;
  double maxClose = 0;
  double maxVolume = 0;

  void setup(BuildContext context){
    _context = context;
    loadItems();
  }

  void loadItems({bool silently=false}){

    loadingError = null;
    if(!silently)pageIsLoading=true;
    notifyListeners();

    String symbol = (getArgs(_context!) as StockReportArgument).symbol;
    HttpService.getAPICall(ApiPaths.intraday, (response, error){
      if(error!=null){
        if(!silently)loadingError=error;
        notifyListeners();
        return;
      }

      allItemList = response["data"]??[];
      // for(Map map in list){
      //   if(map.containsValue(null))continue;
      //   allItemList.add(map);
      // }
      filterResults();
      pageIsLoading=false;
      notifyListeners();
    },data: {
      "symbols":symbol,
      "date_from":
      TimeUtils.formatTime3(startTimeMilli),
      "date_to":
      TimeUtils.formatTime3(endTimeMilli),
      "limit":50,
      "interval":"24hour"
    }
    );
  }

  void filterResults(){
    itemList.clear();
    maxOpen = 0;
    maxHigh = 0;
    maxLow = 0;
    maxLast = 0;
    maxClose = 0;
    maxVolume = 0;
    for (dynamic element in allItemList) {
      ChartDataModel chartDataModel = ChartDataModel.fromJson(element);
      DateTime date = getRealTimeMilli(chartDataModel.date);
      int time = date.millisecondsSinceEpoch;
      if(time<startTimeMilli)continue;
      if(time>endTimeMilli)continue;
      itemList.add(chartDataModel);
      maxOpen = max(maxOpen, chartDataModel.open);
      maxHigh = max(maxHigh, chartDataModel.high);
      maxLow = max(maxLow, chartDataModel.low);
      maxLast = max(maxLast, chartDataModel.last);
      maxClose = max(maxClose, chartDataModel.close);
      maxVolume = max(maxVolume, chartDataModel.volume);

      maxValue = max(maxValue, maxOpen);
      maxValue = max(maxValue, maxHigh);
      maxValue = max(maxValue, maxLow);
      maxValue = max(maxValue, maxLast);
      maxValue = max(maxValue, maxClose);
    }
    notifyListeners();
  }

  DateTime getRealTimeMilli(String time){
    return DateTime.parse(time);
  }
}