import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibd/models/Localization.dart';
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

class PrintersLocalizations extends StatefulWidget {
  const PrintersLocalizations({Key? key}) : super(key: key);


  @override
  State<PrintersLocalizations> createState() => _LocalizationState();
}

class _LocalizationState extends State<PrintersLocalizations> {
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

          TextEditingController city = TextEditingController();
          TextEditingController street = TextEditingController();
          TextEditingController postcode = TextEditingController();


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
                          TextFormField(
                            onTap: (){
                                      setState(() {
                                      reverse = false;
                                    });
                                          },
                            controller: city,
                            validator: (value) {
                              if(value!=null){
                                return null;
                              }else{
                                return "Pole nie moze byc puste";
                              }
                            },  
                            decoration: InputDecoration(labelText: 'Miasto'),
                          ),
                          TextFormField(
                            onTap: (){
                                      setState(() {
                                      reverse = true;
                                    });
                                          },
                            controller: street,
                            validator: (value) {
                        if(value!=null){
                                return null;
                              }else{
                                return "Pole nie moze byc puste";
                              }
                            },
                            decoration: InputDecoration(labelText: 'Ulica'),
                          ),
                          TextFormField(
                            onTap: (){
                                      setState(() {
                                      reverse = true;
                                    });
                                          },
                            controller: postcode,
                            validator: (value) {
                              if(value!=null){
                                return null;
                              }else{
                                return "Pole nie moze byc puste";
                              }
                            },
                            decoration: InputDecoration(labelText: 'Kod pocztowy'),
                          ),

                        ],
                      )))),
              title: Text('Dodaj lokalizacje'),
              actions: <Widget>[
                InkWell(
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          
                          
            provider
                .add(
                  Localization(city: city.text,postcode: postcode.text,street:street.text)
                  )
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
                      child: Text("Dodaj lokalizacje")),
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

                                 await provider.remove(provider.list![index].idlocalization??0,index).then((value){
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

