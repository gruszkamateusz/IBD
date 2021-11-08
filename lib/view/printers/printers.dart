import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibd/models/Printer.dart';

import 'package:ibd/providers/printers_provider.dart';
import 'package:ibd/view/widgets/drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Printers extends StatefulWidget {
  const Printers({Key? key}) : super(key: key);


  @override
  State<Printers> createState() => _PrintersState();
}

class _PrintersState extends State<Printers> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

   // final provider = Provider.of<PrinterProvider>(context);

    return Scaffold(
      drawer: DrawerApp(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {

                var uri = 'http://127.0.0.1:8080/printers/add?idprinters=10idlocalization=1owner=\"test\"owner=\"type\"';
            final response = await http.post(
              Uri.parse(uri),
                headers: {
                "Access-Control_Allow_Origin": "*"
            },
                );

                final snackBar = SnackBar(content: Text(response.statusCode.toString()));

              ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }),
      appBar: AppBar(
        title:Text("IBD"),
        centerTitle: true,
      ),
      //body:Container(color:Colors.red)
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Consumer<PrinterProvider>(
        builder: (_, provider, __) =>
          provider.loading?
      Center(
        child: CircularProgressIndicator()):
      
      Expanded(
        child: ListView.builder(
          itemCount: provider.list!.length,
          itemBuilder: (context,index){
            return ExpansionTile(
              title:Text(provider.list![index].type??''),
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
                                 await provider.remove(provider.list![index].id??0,index).then((value){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(value),duration: Duration(milliseconds:1000),)
                                    );
                                  });

                  },
              )],)),
              children:[
                ListTile(
                  leading: Text("Typ:"),
                  trailing: Text(provider.list![index].type??''),
                ),
                ListTile(
                  leading: Text("Wlasiciel:"),
                  trailing: Text(provider.list![index].owner??''),
                ),
                ListTile(
                  leading: Text("Lokalizacja:"),
                  trailing: Text(provider.list![index].localization.toString()),
                ),
              ] );}
            )
    )
      )])
    );
  }

  TextEditingController dotId = TextEditingController();
  TextEditingController dotDate = TextEditingController();
  var loading = false;
  late FormState _form;


   showAddEditDialog(BuildContext context,Printer printer, bool edit, PrinterProvider provider) {


    bool isActive = false;
    String nameButton = "Zatwierdź";
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    var reverse = false;

      if( printer != null&&edit){

        dotId.text = printer.id.toString();
        dotDate.text = printer.type!;


      }else{

        dotId.text = '';
        dotDate.text = '';

      }


    return showDialog(
        context: context,
        builder: (context) {
          if (edit) {
            nameButton = "Edytuj";
          }
          return StatefulBuilder(builder: (context, setState) {
            return  
            AlertDialog(
              content:  SingleChildScrollView(
          reverse: reverse,
          child:Container(
              height: loading?MediaQuery.of(context).size.height*0.2:MediaQuery.of(context).size.height*0.9,
              width: MediaQuery.of(context).size.width*0.8,
              child:Form(
                  key: _formKey,
                  child: Container(
                      margin: EdgeInsets.only(top: 2.0, bottom: 5.0),
                      child: loading?Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          Text("Prosze czekac", style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
                        ]):Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(edit?"Edytuj zasob:":"Utworz nowy zasob:", style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
  
                          Visibility(
                            visible: !edit,
                            child:
                         TextFormField(
                                  controller: dotId,
                                  decoration: new InputDecoration(
                                      hintText: "ID",
                                      labelText: "ID"),
                                  // validator: validateTob,
                                  onSaved: (value) {
                                      dotId.text = value!;
                                  },
                                  onChanged: (value) {
                                      dotId.text = value;

                                  },
                                  // ignore: missing_return
                                  validator: (value) {
                                    if (value == null) {
                                      return "Podaj ID";
                                    }
                                    return null;
                                  })),
                          Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          //margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: InkWell(
                            onTap: () async {
                              DateTime date = DateTime(1900);
                              TimeOfDay dateTime =
                                  TimeOfDay(hour: 12, minute: 0);
                              date = (await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100)))!;
                              dateTime = (await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(hour: 12, minute: 0)))!;
                              if (date != null) {
                                if(dateTime !=null){
                                date = date.add(Duration(hours: dateTime.hour, minutes : dateTime.minute ));
                                }

                                dotDate.text = DateFormat("yyyy-MM-dd HH:mm").format(date);
                              }
                            },
                            child: IgnorePointer(
                              child: new TextFormField(
                                  controller: dotDate,
                                  decoration: new InputDecoration(
                                      hintText: "Data",
                                      labelText: "Data"),
                                  // validator: validateTob,
                                  onSaved: (value) {
                                      dotDate.text = value!;
                                  },
                                  onChanged: (value) {
                                      dotDate.text = value;

                                  },
                                  // ignore: missing_return
                                  validator: (value) {
                                    if (value == null) {
                                      return "Podaj date";
                                    }
                                    return null;
                                  }),
                            ),
                          ),
                        ),
                      ])
  ),
                        ],
                      ))))),
              title: Text(''),
              actions: <Widget>[
                loading?Container():
                InkWell(
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if(edit){
                              var response = await provider.edit(printer.id!, dotDate.text);

                                    Navigator.of(context).pop();                      
                                ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(response),duration: Duration(milliseconds:1000),)
                                    );
                          }else{

                              // var response = await provider.add(int.parse(dotId.text), dotDate.text);

                              //       Navigator.of(context).pop();                      
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(
                              //       behavior: SnackBarBehavior.floating,
                              //       content: Text(response),duration: Duration(milliseconds:1000),)
                              //       );
                          }

                        }},

                      child: Text(nameButton)),
                ),
              ],
            );
          });
        });
  }


}

