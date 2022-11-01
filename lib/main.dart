import 'package:basalt/basalt.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<RootViewModel>(create: (_) => RootViewModel()),
      ChangeNotifierProvider<HomeViewModel>(create: (_) => HomeViewModel()),
      ChangeNotifierProvider<StockViewModel>(create: (_) => StockViewModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basalt',
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async {
          bool screenPopped = await AppRouter.appNavigatorKey.currentState?.maybePop() ?? false;
          return !screenPopped;
        },
        child: Navigator(
          key: AppRouter.appNavigatorKey,
          onGenerateRoute: AppRoutes.getRoute,
        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
