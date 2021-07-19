import 'package:flutter/material.dart';
import 'package:og_flutter/api_service.dart';
import 'package:og_flutter/detail_screen.dart';
import 'package:og_flutter/list_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  runApp(
    ModularApp(
      module: AppModule(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ApiService(),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(ListScreen.routeName, child: (_, __) => ListScreen()),
        ChildRoute(
          "${DetailScreen.routeName}/:id",
          child: (_, args) => DetailScreen(
            id: int.parse(
              args.params['id'].toString(),
            ),
          ),
        ),
      ];
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OG Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ListScreen.routeName,
    ).modular();
  }
}
