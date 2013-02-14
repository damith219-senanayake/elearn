
library elearn;
import 'dart:io';
import 'question.dart';

class questionloader{
  Map questions=new Map();
  questionloader(){
  
  File f = new File('my_textfile.txt');
  // fileStream = f.openInputStream();
  //StringInputStream stringStream = new StringInputStream(fileStream);
 // print(stringStream.read());
  //FileReader fr= new FileReader();
  //fileStream.close();
  
  List strings=f.readAsLinesSync();
  
  
    for(int i=0;i<937;i++){
  
      try{
         int k=i*13;
      String qnm=strings[k];
       String qt=strings[k+1];
      Map ans=new Map();
      ans['1']=strings[k+2];
     ans['2']=strings[k+3];
     ans['3']=strings[k+4];
      ans['4']=strings[k+5];
    
      String ca=strings[k+6];
      String qx=strings[k+7];
      String tp=strings[k+8];
    
      Map aes=new Map();
      aes['1']=strings[k+9];
      ans['2']=strings[k+10];
      ans['3']=strings[k+11];
       ans['4']=strings[k+12];
      questions[qnm]= new question(qnm,qt,qx,ans,ca,aes,tp);
     String str=questions[qnm].getqus_text();
      //print(str);
      }catch(exception){
       print(i);
     }
    //print(questions.toString());
    }
    
  String str=questions['2'].getqus_text();
  //print(str);
  }

  Map getQuestions(){  
    return this.questions;
  }

}
