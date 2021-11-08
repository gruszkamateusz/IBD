
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ibd/providers/dots_provider.dart';
import 'package:ibd/view/widgets/drawer.dart';
import 'package:provider/provider.dart';

class Dots extends StatefulWidget {
  const Dots({Key? key}) : super(key: key);


  @override
  State<Dots> createState() => _DotsState();
}

class _DotsState extends State<Dots> {

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      drawer: DrawerApp(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {

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
                  leading: Text("Data:"),
                  trailing: Text(provider.list![index].date??''),
                ),
                ListTile(
                  leading: Text("Drukarka:"),
                  trailing: Text(provider.list![index].idprinter.toString()),
                ),
              ] );}
            )
    )
      )])
    );
  }


}

