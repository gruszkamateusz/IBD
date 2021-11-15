
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ibd/models/Dot.dart';
import 'package:ibd/models/Printer.dart';
import 'package:ibd/providers/dots_provider.dart';
import 'package:ibd/providers/printers_provider.dart';
import 'package:ibd/view/widgets/drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Dots extends StatefulWidget {
  const Dots({Key? key}) : super(key: key);


  @override
  State<Dots> createState() => _DotsState();
}

class _DotsState extends State<Dots> {
    Printer? printerValue;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<DotProvider>(context);

    final printerProvider = Provider.of<PrinterProvider>(context);

    return Scaffold(
      drawer: DrawerApp(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
 TextEditingController printer = TextEditingController();
 TextEditingController title = TextEditingController();
          TextEditingController dateFrom = TextEditingController();


          FormState _form;


          final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
          var reverse = false;


     showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content:  SingleChildScrollView(
          reverse: reverse,
          child:Form(
                  key: _formKey,
                  child: Container(
                      margin: EdgeInsets.only(top: 2.0, bottom: 5.0),
                      child: Column(
                        children: [

 Container(
                            child: DropdownButton<Printer?>(
                                        isExpanded: true,
                                        value: printerValue,
                                        icon: const Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        elevation: 24,
                                        style: const TextStyle(color: Colors.black),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.black,
                                        ),
                                         onChanged: (Printer? value){
                                           setState((){
                                             printerValue = value;
                                           });
                                             
                                         },
                                        items: printerProvider.list!.map<DropdownMenuItem<Printer?>>(
                                              (item) =>
                                                  new DropdownMenuItem<Printer?>(
                                                value: item,
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.business_outlined),
                                                    Text("[${item.id}] ${item.type}",style:TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                                                  
                                                                ])
                                                ),
                                            )
                                            .toList()
                                      ),                     

                                    ),










                          //                           TextFormField(
                          //   onTap: (){
                          //             setState(() {
                                      
                          //           });
                          //                 },
                          //   controller: printer,
                          //   validator: (value) {
                          //     if(value!=null){
                          //       return null;
                          //     }else{
                          //       return "Pole nie moze byc puste";
                          //     }
                          //   },  
                          //   decoration: InputDecoration(labelText: 'Drukarka'),
                          // ),
                          TextFormField(
                            onTap: (){
                                      setState(() {
                                      reverse = false;
                                    });
                                          },
                            controller: title,
                            validator: (value) {
                              if(value!=null){
                                return null;
                              }else{
                                return "Pole nie moze byc puste";
                              }
                            },  
                            decoration: InputDecoration(labelText: 'Tytul'),
                          ),
                                       Container(
                        height: 60,
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

                                dateFrom.text = DateFormat("yyyy-MM-dd HH:mm").format(date);
                              }
                            },
                            child: IgnorePointer(
                              child: new TextFormField(
                                  controller: dateFrom,
                                  decoration: new InputDecoration(
                                      hintText: "Data od",
                                      labelText: "Data od"),
                                  // validator: validateTob,
                                  onSaved: (value) {
                                      dateFrom.text = value!;
                                  },
                                  onChanged: (value) {
                                      dateFrom.text = value;

                                  },
                                  // ignore: missing_return
                                  validator: (value) {
                                    if (value == null) {
                                      return "Podaj date od";
                                    }
                                    return null;
                                  }),
                            ),
                          ),
                        ),
                      ])
  ),

                        ],
                      )))),
              title: Text('Dodaj wydruk'),
              actions: <Widget>[
                InkWell(
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
            provider
                .add(Dot(printer: printerValue,title: title.text,date: DateFormat('"yyyy-MM-ddTHH:mm:ss').format(DateTime.parse(dateFrom.text)).toString()))
                .then((result) => {
                  print(result),

                          Navigator.of(context).pop(),
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(result),
                              duration: Duration(milliseconds: 2000),
                              )
                            ),
                    });
                       
                        }
                      },
                      child: Text("Dodaj drukarkę")),
                ),
              ],
            );
          });
        });
      }),
      appBar: AppBar(
        title:Text("IBD"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Consumer<DotProvider>(
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

                                 await provider.removeDot(provider.list![index].id??0,index).then((value){
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
                  leading: Text("Data:"),
                  trailing: Text(provider.list![index].date??''),
                ),
                ExpansionTile(
                   title: Text("Drukarka:"),
                   children:[
                ListTile(
                  leading: Text("Wlasciciel:"),
                  trailing: Text(provider.list![index].printer!.owner.toString()),
                ),
                ListTile(
                  leading: Text("Typ:"),
                  trailing: Text(provider.list![index].printer!.type.toString()),
                ),
              //   ExpansionTile(
              //      title: Text("Lokalizacja:"),
              //      children:[
              //   // ListTile(
              //   //   leading: Text("Miasto:"),
              //   //   trailing: Text(provider.list![index].printer!.localization!.city.toString()),
              //   // ),
              //   // ListTile(
              //   //   leading: Text("Ulica:"),
              //   //   trailing: Text(provider.list![index].printer!.localization!.street.toString()),
              //   // ),
              //   // ListTile(
              //   //   leading: Text("Kod poczowy:"),
              //   //   trailing: Text(provider.list![index].printer!.localization!.postcode.toString()),
              //   // ),
              // ] 
              //   ),
              ] 
                ),
              ] );}
            )
    )
      )])
    );
  }


}

