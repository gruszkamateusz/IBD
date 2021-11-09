import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ibd/providers/dots_provider.dart';
import 'package:ibd/providers/localization_provider.dart';
import 'package:ibd/providers/printers_provider.dart';
import 'package:ibd/providers/printouts_provider.dart';
import 'package:ibd/view/dots/dots.dart';
import 'package:ibd/view/home/home.dart';
import 'package:ibd/view/localization/localization.dart';
import 'package:ibd/view/printers/printers.dart';
import 'package:ibd/view/printouts/printouts.dart';
import 'package:ibd/view/routes.dart';
import 'package:provider/provider.dart';

import 'MyHttpsOverrider.dart';
void main() {
 HttpOverrides.global = new MyHttpOverrides();
  runApp(
    const MyApp()
    );
 
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: LocalizationProvider(),
        ),
        ChangeNotifierProvider.value(
          value: PrintoutProvider(),
        ),
        ChangeNotifierProvider.value(
          value: PrinterProvider(),
        ),
        ChangeNotifierProvider.value(
          value: DotProvider(),
        ),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IBD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.home,
          routes: {
            Routes.home: (context) => new Home(),
            Routes.printers: (context) => new Printers(),
            Routes.printouts: (context) => new Printouts(),
            Routes.dots: (context) => new Dots(),
            Routes.localization: (context) => new PrintersLocalizations(),
          },
    ));
  }
}
