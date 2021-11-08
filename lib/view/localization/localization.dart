import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibd/models/Printer.dart';
import 'package:ibd/models/Printout.dart';
import 'package:ibd/providers/Dots_provider.dart';
import 'package:ibd/providers/Dots_provider.dart';
import 'package:ibd/providers/localization_provider.dart';
import 'package:ibd/view/printouts/printouts.dart';
import 'package:ibd/view/widgets/drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Localization extends StatefulWidget {
  const Localization({Key? key}) : super(key: key);


  @override
  State<Localization> createState() => _LocalizationState();
}

class _LocalizationState extends State<Localization> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      drawer: DrawerApp(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {

          //  var uri = 'http://127.0.0.1:8080/Dots/all';
          //  print(Uri.parse(uri));
          //   final response = await http.get(
          //     Uri.parse(uri),
          //       headers: {
          //       "Access-Control_Allow_Origin": "*"
          //   },
            
          //       );
          //       print(response.body);

          //       final snackBar = SnackBar(content: Text(response.body));

          //     ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }),
      appBar: AppBar(
        title:Text("IBD"),
        centerTitle: true,
      ),
      //body:Container(color:Colors.red)
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Consumer<LocalizationProvider>(
        builder: (_, provider, __) =>
          provider.loading?
      Center(
        child: CircularProgressIndicator()):
      
      Expanded(
        child: ListView.builder(
          itemCount: provider.list!.length,
          itemBuilder: (context,index){
            return ExpansionTile(
              title:Text(provider.list![index].city??''),
              trailing: Container(
                height: 100,
                width: 100,
                child: Row(
                children: [
                  IconButton(
              icon: 
                Icon(
                    Icons.edit,
                    color: Colors.blue,
                    size: 25,
                  ),
           
                  onPressed: () async {                
                    //showAddEditDialog(context, provider.list![index], true, provider);
                  },
              ),
                  IconButton(
              icon: 
                Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 25,
                  ),
                  onPressed: () async {

                                //  await provider.removeDot(provider.list![index].id??0,index).then((value){
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                // SnackBar(
                                //     behavior: SnackBarBehavior.floating,
                                //     content: Text(value),duration: Duration(milliseconds:1000),)
                                //     );
                                //   });

                  },
              )],)),
              children:[

                ListTile(
                  leading: Text("Ulica:"),
                  trailing: Text(provider.list![index].street??''),
                ),
                ListTile(
                  leading: Text("Kod pocztowy:"),
                  trailing: Text(provider.list![index].postcode??''),
                ),
              ] );}
            )
    )
      )])
    );
  }


}

