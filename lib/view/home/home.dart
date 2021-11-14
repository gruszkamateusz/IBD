import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ibd/providers/dots_provider.dart';
import 'package:ibd/providers/localization_provider.dart';
import 'package:ibd/providers/printers_provider.dart';
import 'package:ibd/providers/printouts_provider.dart';
import 'package:ibd/view/printers/printers.dart';
import 'package:ibd/view/printouts/printouts.dart';
import 'package:ibd/view/widgets/drawer.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerApp(),
      appBar: AppBar(
        title:Text("Save your dots"),
        centerTitle: true,
      ),
      body: Consumer4<PrinterProvider, PrintoutProvider,LocalizationProvider, DotProvider>(
    builder: (context, printersProvider, printoutProvider, localizationProvider, dotProvider, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment : CrossAxisAlignment.center,
        children: [
          Text("Witamy w aplikacji wspomagającej archiwizacje zoltych kropek", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
          
          Row (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width*0.4,
                height: size.height*0.4,
                child:
              Card(
                 elevation: 0.5,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment : CrossAxisAlignment.center,
                      children: [
                        Text("Ilosc dostepnych drukarek: ", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400)),
                        Text(printersProvider.list!.length.toString(), style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600))
                      ]
                ),
              )))
              ,
              Container(
                width: size.width*0.4,
                height: size.height*0.4,
                child:Card(
                   elevation: 0.5,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment : CrossAxisAlignment.center,
                      children: [
                        Text("Ilosc dostepnych lokalizacji: ", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400)),
                        Text(localizationProvider.list!.length.toString(), style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600))
                      ]
                )),
              ))

            ],),
            Row (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width*0.4,
                height: size.height*0.4,
                child:Card(
                   elevation: 0.5,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment : CrossAxisAlignment.center,
                      children: [
                        Text("Ilosc wydruków: ", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400)),
                        Text(dotProvider.list!.length.toString(), style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600))
                      ]
                ),
              ))),
             Container(
                width: size.width*0.4,
                height: size.height*0.4,
                child: Card(
                  elevation: 0.5,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment : CrossAxisAlignment.center,
                      children: [
                        Text("Ilość przeanalizowanych kropek: ", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400)),
                        Text(dotProvider.list!.length.toString(), style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600))
                      ]
                ),
              )))

            ],)
      ],);

    }
    ),
    );
      }
  }