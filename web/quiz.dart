library elearn;
import 'question.dart';
import 'dart:math';
class question{
  String quNum;
  String qus_txt;
  String qus_exp;
  var answers=new Map();
  var c_ans;
  var ans_exps=new Map();
  int topic;
  bool done;
  
  question(qn,qt,qe,ans,cans,anex,tp,bool d){
    this.qus_txt=qt;
    this.qus_exp=qe;
    this.answers=ans;
    this.c_ans=cans;
    this.ans_exps=anex;
    this.topic=tp;
    this.quNum=qn;
    this.done=d;
  }
  
  bool check_ans(value){
    bool x=false;
    if(value==c_ans){
      x=true;
    }
    return x;
  }
  
  Map get_answers(){
    return this.answers;
  }
  Map get_ansexps(){
    return this.ans_exps;
  }
  
  String getqus_text(){
    return this.qus_txt;
  }
  String getqus_exp(){
    return this.qus_exp;
  }
  
}

List shuffle(List items) {
  var random = new Random();

  // Go through all elements.
  for (var i = items.length - 1; i > 0; i--) {

    // Pick a pseudorandom number.
    var n = random.nextInt(items.length + 1);

    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }

  return items;
}

class quiz{
  
  List<question> qus_set;
  var done_qus,fresh_qus;
  int quiz_size;
  String quiz_type;
  int topic;  
  
  quiz(int size,String type,int tp, List<question> dq, List<question> fq){
    this.done_qus=dq;
    this.fresh_qus=fq;
    this.quiz_size=size;
    this.quiz_type=type;
    this.topic=tp;
  }
  
  
  List<question> get_question_set(){
    return qus_set;
  }
  
 List<question> set_question_set(){
    
    var dq=shuffle(done_qus);
    var fq=shuffle(fresh_qus);
    double tempx=quiz_size*pow((dq.length/(dq.length+fq.length)),3);
    int cnt=0;
    var qs=new List<question>();
    for(int i=0;i<tempx.floor();i++){
      qs.add(dq[i]);
      cnt++;
    }
    
    double tempy=quiz_size-tempx.floor();
    for(int i=0;i<tempy;i++){
      qs.add(fq[i]);
      cnt++;
    }
    qus_set=qs;
    return qs;
  }
  
}
