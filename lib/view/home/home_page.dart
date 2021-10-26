import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibd/models/yellow_dots.dart';
import 'package:ibd/providers/home_provider.dart';
import 'package:intl/intl.dart';
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

    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
        showAddEditDialog(context, YellowDots(), false, homeProvider);
      }),
      appBar: AppBar(
        title:Text("IBD"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Consumer<HomeProvider>(
        builder: (_, homeProvider, __) =>
          homeProvider.loading?
      Center(
        child: CircularProgressIndicator()):
      
      Expanded(
        child: ListView.builder(
          itemCount: homeProvider.list.length,
          itemBuilder: (context,index){
            return ExpansionTile(
              title:Text(homeProvider.list[index].data??''),
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
                    showAddEditDialog(context, homeProvider.list[index], true, homeProvider);
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
                                 await homeProvider.removeDot(homeProvider.list[index].id??0).then((value){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(value),duration: Duration(milliseconds:4000),)
                                    );
                                  });

                  },
              )],)),
              children:[
                Column(children: [
                  Image(image: AssetImage('assets/yellow_dots.png')),
                ],)
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


   showAddEditDialog(BuildContext context,YellowDots yellowDot, bool edit, HomeProvider homeProvider) {


    bool isActive = false;
    String nameButton = "Zatwierdź";
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    var reverse = false;

      if( yellowDot != null&&edit){

        dotId.text = yellowDot.id.toString();
        dotDate.text = yellowDot.data!;


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
                              var response = await homeProvider.editDot(yellowDot.id!, dotDate.text);

                                    Navigator.of(context).pop();                      
                                ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(response),duration: Duration(milliseconds:1000),)
                                    );
                          }else{

                              var response = await homeProvider.addDot(int.parse(dotId.text), dotDate.text);

                                    Navigator.of(context).pop();                      
                                ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(response),duration: Duration(milliseconds:1000),)
                                    );
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

