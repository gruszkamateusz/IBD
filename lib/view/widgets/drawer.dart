import 'package:flutter/material.dart';
import 'package:ibd/view/dots/dots.dart';
import 'package:ibd/view/home/home.dart';
import 'package:ibd/view/localization/localization.dart';
import 'package:ibd/view/printers/printers.dart';
import 'package:ibd/view/printouts/printouts.dart';

class DrawerApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new UserAccountsDrawerHeader(
                accountName: new Text("Save your dots",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
                accountEmail: new Text("Archiwum zoltych kropek",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                decoration:new BoxDecoration(color: Theme.of(context).primaryColor),
              ),

              Divider(),
                            ListTile(
                leading: Icon(Icons.home, size: 30),
                title: Text("Ekran glowny"),
                onTap: () {
                                     Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                },
              ),

               Divider(),
              ListTile(
                leading: Icon(Icons.print_rounded, size: 30),
                title: Text("Drukarki"),
                onTap: () {
                                     Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Printers()),
                      );
                },
              ),

              ListTile(
                leading: Icon(Icons.list,size: 30),
                title: Text("Wydruki"),
                onTap: () {

                                     Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Printouts()),
                      );

                },
              ),
              ListTile(
                leading: Icon(Icons.list,size: 30),
                title: Text("Kropki"),
                onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Dots()),
                      );

                },
              ),
              ListTile(
                leading: Icon(Icons.location_city,size: 30),
                title: Text("Lokalizacja"),
                onTap: () {

                                     Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Localization()),
                      );

                },
              ),
            ]));
  
}
}