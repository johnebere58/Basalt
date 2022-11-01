import 'package:basalt/basalt.dart';
import 'package:basalt/models/chart_data_model.dart';

class StockViewModel extends BaseViewModel{

  BuildContext _context;
  int? startTimeMilli;
  int? endTimeMilli;
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

    HttpService.getAPICall(ApiPaths.intraday, (response, error){
      if(error!=null){
        if(!silently)loadingError=error;
        notifyListeners();
        return;
      }

      allItemList = response["data"]??[];
      filterResults();
      pageIsLoading=false;
      notifyListeners();
    },data: {"symbols":(getArgs(_context) as StockReportArgument).symbol});
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
      DateTime date = DateTime.parse(chartDataModel.date);
      int time = date.millisecondsSinceEpoch;
      if(startTimeMilli!=null && time<startTimeMilli!)continue;
      if(endTimeMilli!=null && time>endTimeMilli!)continue;
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

}