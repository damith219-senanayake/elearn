

library elearn;

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
