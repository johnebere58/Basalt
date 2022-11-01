import 'package:basalt/basalt.dart';

class BaseViewModel extends ChangeNotifier{

  BaseViewModel();

  bool pageIsLoading = false;

  String? loadingError;

  bool _disposed = false;

  @override
  void notifyListeners(){
    if(!_disposed){
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed=true;
    super.dispose();
  }

  Object? getArgs(BuildContext context){
    return ModalRoute.of(context)!.settings.arguments;
  }
}