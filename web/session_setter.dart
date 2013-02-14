library elearn;

//import 'question.dart';
import 'quiz.dart';


class session_setter {
  var comp_qus_set=new List<question>();
  var qulist;
  int size;
  String type;
  
  
  new_topic_session(int tn){
    
    var done_qs=new List<question>();
    var fresh_qs=new List<question>();
    qulist  =new List<question>();
      //qulist.length=10;
     question q= new question('a','b','c',new Map(),'d',new Map(),1,false);
     qulist.add(q);
     qulist.add(new question('a','b1','c',new Map(),'d',new Map(),1,false));
     qulist.add(new question('a','b2','c',new Map(),'d',new Map(),1,false));
     qulist.add(new question('a','b3','c',new Map(),'d',new Map(),1,false));
     
     for(int i=0;i<qulist.length;i++){
       print(qulist[i].getqus_text());
     }
  
     for(int i=0;i<comp_qus_set.length;i++){
       if(comp_qus_set[i].done){
         done_qs.add(comp_qus_set[i]);
       }
       else {
         fresh_qs.add(comp_qus_set[i]);
       }
     }
     quiz qz= new quiz(5,type,1,done_qs,fresh_qs);
     qulist=qz.set_question_set();
     
    
  }
}

class session{
  String type;
    
}
class topic_session extends session{
  topic_session(int topic,String type){
    this.type=type;
  }
  
}
class complete_session extends session{
  complete_session(String type){
    this.type=type;
  }
  
}
main(){
  session_setter ss=new session_setter();
  ss.new_topic_session(1);
}