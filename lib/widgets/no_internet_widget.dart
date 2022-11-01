import 'package:basalt/basalt.dart';

class NoInternetWidget extends StatefulWidget {
  const NoInternetWidget({Key? key}) : super(key: key);

  @override
  State<NoInternetWidget> createState() => _NoInternetWidgetState();
}

class _NoInternetWidgetState extends State<NoInternetWidget> {

  late StreamSubscription streamSubscription;
  bool noInternet = false;

  @override
  void initState() {

    streamSubscription = Connectivity().onConnectivityChanged.listen((event) {
      if(event==ConnectivityResult.none){
        setState(() {
          noInternet=true;
        });
      }else{
        setState(() {
          noInternet=false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding:  !noInternet?EdgeInsets.zero: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        decoration: const BoxDecoration(
          color: Colors.red,
           ),
        child: !noInternet?const SizedBox():Text("No Internet Connectivity",style: (14).asTextStyle(true,color: Colors.white),),
      ),
    );
  }
}
