library elearn;

import 'package:mongo_dart/mongo_dart.dart';
//import 'package:json/json.dart';
import 'questionloader.dart';
import 'package:json_object';
import 'dart:json';
//import "dart:json";
class questionSetter{
  
  questionSetter(){
    questionloader ql=new questionloader();
    
    Map qmap=ql.questions;
    //var json= json(qmap);
    //print(stringify((qmap)));
  }

  
  
}

class person{
  
  String name;
  String index;
  
  person(){
    name="hello";
    index= "1110";
  }
  
}
main(){
 print("bp1");
  person p=new person();
  print("bp2");
  try{
   print(stringify(p));
  }catch( e){
    e.printStackTrace();
  }
  print ("done");
  
}