import 'package:flutter/material.dart';
import 'package:ibd/providers/home_provider.dart';
import 'package:ibd/view/home/home_page.dart';
import 'package:ibd/view/routes.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: HomeProvider(),
        ),
      ],
      child: MaterialApp(
      title: 'IBD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.home,
          routes: {
            Routes.home: (context) => new Home(),
            Routes.formular: (context) => Container(child: Text("Formularz"),),
          },
    ));
  }
}
