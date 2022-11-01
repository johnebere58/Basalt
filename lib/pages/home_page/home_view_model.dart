import 'package:basalt/basalt.dart';

class HomeViewModel extends BaseViewModel{

  List allItemList = [];
  List itemList = [];
  StateSetter? searchStateSetter;
  ScrollController scrollController = ScrollController();
  double scrollPosition = 0;
  bool showCancel = false;
  FocusNode focusSearch = FocusNode();
  TextEditingController searchController = TextEditingController();

  void setup(){
    loadItems();
    scrollController.addListener((){
      updatedScrollPosition();
    });
  }

  void loadItems({bool silently=false}){

    loadingError = null;
    if(!silently)pageIsLoading=true;
    notifyListeners();

    HttpService.getAPICall(ApiPaths.exchanges, (response, error){
      if(error!=null){
        loadingError=error;
        notifyListeners();
        return;
      }

      allItemList = response["data"]??[];
      performSearch();
      pageIsLoading=false;
      notifyListeners();
    },data: {"limit":10});
  }

  void performSearch(){
    String search = searchController.text.trim();
    itemList.clear();
    for(Map data in allItemList){
      String text = data.toString().trim();
      if(search.isNotEmpty && !text.toLowerCase().contains(search.toLowerCase()))continue;
      itemList.add(data);
    }
    pageIsLoading=false;
    notifyListeners();
  }

  void updatedScrollPosition(){
    scrollPosition = scrollController.position.pixels;
    searchStateSetter!((){});
  }

  @override
  void dispose() {
    scrollController.dispose();
    focusSearch.dispose();
    searchController.dispose();
    super.dispose();
  }


}