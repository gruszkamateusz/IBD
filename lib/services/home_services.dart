import 'package:ibd/models/yellow_dots.dart';

class HomeServices{

    Future<List<YellowDots>> fetchData() async {
      
      await Future.delayed(Duration(seconds: 2));

  return Future<List<YellowDots>>.value([
    YellowDots(
      id:1,
      data: "21:00 12-12-2000"),
    YellowDots(
      id:2,
      data: "21:00 12-12-2004"),
    YellowDots(
      id:3,
      data: "21:00 12-12-2003"),
    YellowDots(
      id:4,
      data: "21:00 12-12-2002"),
    ]);
  }

  Future<int> remove(int id) async {
      
      await Future.delayed(Duration(seconds: 1));

    if(id != 0){
        return 200;
    }else{
      return 404;
    }

  }
    Future<int> add(int id, String data) async {
      
      await Future.delayed(Duration(seconds: 1));

    if(id != 0){
        return 201;
    }else{
      return 404;
    }

  }
      Future<int> edit(int id, String data) async {
      
    await Future.delayed(Duration(seconds: 1));

    if(id != 0){
        return 200;
    }else{
      return 404;
    }

  }
}