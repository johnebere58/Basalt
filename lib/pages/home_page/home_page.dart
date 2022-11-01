import 'package:basalt/basalt.dart';
import  'dart:ui';

import 'package:basalt/navigation/arguments/stock_report_argument.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeViewModel? _model;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     _model!.setup();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  Consumer<HomeViewModel>(
      builder: (_,model,__) {
        _model ??= model;
        return Scaffold(
            backgroundColor: Colors.white,
            body:
            Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(ImageAssets.stock,fit: BoxFit.cover,),
                BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Container(
                      color: Colors.black.withOpacity(.4),
                    )),
                model.loadingError!=null?
                EmptyLayout(Icons.info, "Oops!", "${model.loadingError}",
                  clickText: "Retry",click: (){
                    model.loadItems();
                  },titleColor: Colors.white,textColor: Colors.white,):
                model.pageIsLoading?
                const LoadingWidget(height: 200,
                trans: true,)
                    :body()
              ],
            )
        );
      }
    );
  }

  Widget body(){

    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 100),
            child: SingleChildScrollView(
              controller: _model!.scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [

                  100.asHeight,
                  Column(
                    children: List.generate(_model!.itemList.length, (index){
                      ExchangeModel exModel = ExchangeModel
                          .fromJson(_model!.itemList[index]);
                      return GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, AppRoutes.stock,
                                arguments: StockReportArgument(exModel.mic));
                          },
                          child: ExchangeWidget(exModel));
                    }),
                  ),

                  50.asHeight,
                ],
              ),
            ),
          ),

          searchWidget(),


        ],
      ),
    );

  }

  Widget searchWidget(){

    return StatefulBuilder(
      builder: (context,state) {
        _model!.searchStateSetter = state;
        FocusNode focusSearch = _model!.focusSearch;
        TextEditingController searchController = _model!.searchController;
        bool showCancel = _model!.showCancel;
        return Stack(
          alignment: Alignment.topCenter,
          children: [

            bannerWidget(),

            AnimatedPositioned(
              top: max(140.0-(_model!.scrollPosition),40.0),
              duration: const Duration(milliseconds: 100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 45,
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    decoration: BoxDecoration(
                      // color: white.withOpacity(.8),
                        borderRadius: BorderRadius.circular(10),
                        border:
                        Border.all(color: focusSearch.hasFocus?ColorAssets.appColor:Colors.white,
                            width: focusSearch.hasFocus?2:1)
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        10.asWidth,
                        Icon(
                          Icons.search,
                          color: focusSearch.hasFocus?ColorAssets.appColor:Colors.white.withOpacity
                            (focusSearch.hasFocus?1:(.5)),
                          size: 17,
                        ),
                        10.asWidth,
                        Flexible(
                          flex: 1,
                          child:  TextField(
                            textInputAction: TextInputAction.search,
                            textCapitalization: TextCapitalization.sentences,
                            autofocus: false,
                            onSubmitted: (_) {
                              _model!.performSearch();
                            },
                            decoration: InputDecoration(
                                hintText: "Search",
                                hintStyle:
                                18.asTextStyle(false,color: Colors.white.withOpacity(.2)),
                                border: InputBorder.none,isDense: true),
                            style: 18.asTextStyle(false,color: Colors.white),
                            controller: searchController,
                            cursorColor: Colors.white,
                            cursorWidth: 1,
                            focusNode: focusSearch,
                            keyboardType: TextInputType.text,
                            onChanged: (s) {
                              _model!.showCancel = s.trim().isNotEmpty;
                              _model!.notifyListeners();
                              _model!.performSearch();
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _model!.showCancel = false;
                            searchController.text = "";
                            _model!.performSearch();
                            _model!.notifyListeners();
                          },
                          child: showCancel
                              ? const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 20,
                            ),
                          )
                              :  const SizedBox(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const NoInternetWidget(),
          ],
        );
      }
    );
  }

  Widget bannerWidget(){

    return IgnorePointer(ignoring: true,
      child: AnimatedOpacity(opacity: (_model!.scrollPosition>10?0:1), duration: const Duration(milliseconds: 100),
        child: Container(
          margin: const EdgeInsets.only(top: 60),
          width: MediaQuery.of(context).size.width - 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(ImageAssets.logo),
              10.asHeight,
              Text("Stock Market Report",style: 12.asTextStyle(false,color: Colors.white.withOpacity(.5)),)
            ],
          ),
        ),),);
  }
}

