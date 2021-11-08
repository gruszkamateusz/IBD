import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibd/models/Printer.dart';
import 'package:ibd/providers/printers_provider.dart';
import 'package:ibd/providers/printouts_provider.dart';
import 'package:ibd/view/printers/printers.dart';
import 'package:ibd/view/routes.dart';
import 'package:ibd/view/widgets/drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Printouts extends StatefulWidget {
  const Printouts({Key? key}) : super(key: key);


  @override
  State<Printouts> createState() => _PrintoutsState();
}

class _PrintoutsState extends State<Printouts> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    //final provider = Provider.of<PrintoutProvider>(context);

    return Scaffold(
      drawer: DrawerApp(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {

          //  var uri = 'http://127.0.0.1:8080/printouts/all';
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
        children: [Consumer<PrintoutProvider>(
        builder: (_, provider, __) =>
          provider.loading?
      Center(
        child: CircularProgressIndicator()):
      
      Expanded(
        child: ListView.builder(
          itemCount: provider.list!.length,
          itemBuilder: (context,index){
            return ExpansionTile(
              title:Text(provider.list![index].title??''),
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
                  //  showAddEditDialog(context, provider.list![index], true, provider);
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

                  },
              )],)),
              children:[
                ListTile(
                  leading: Text("IdPrinter:"),
                  trailing: Text(provider.list![index].idprinter.toString()),
                ),
                ListTile(
                  leading: Text("Data:"),
                  trailing: Text(provider.list![index].date??''),
                ),
              ] );}
            )
    )
      )])
    );
  }

}

