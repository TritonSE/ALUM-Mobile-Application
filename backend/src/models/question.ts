 interface Question{
    readonly question: string;
    readonly type: string;
    answer: string | Array<String>;
    setAnswer(ans : string): void;
 }

 const postSessionQuestionList: Question[] = require('./postQuestionsList.json');
 const preSessionQuestionList : Question[] = require('./preQuestionsList.json');

 class TextQuestion implements Question{
    readonly question: string;
    readonly type: string;
    answer: string;
    constructor(question: string, type: string){
        this.question=question;
        this.type= type;
        this.answer= "";
    }

    public setAnswer(ans: string){
        this.answer=ans;
    }
 }

 class BulletQuestion implements Question{
    readonly question: string;
    readonly type: string;
    answer: Array<String>;
    constructor(question: string, type: string){
        this.question=question;
        this.type=type
        this.answer=new Array<String>;
    }

    public setAnswer(ans: string){
        this.answer.push(ans);
    }
 }
 
 for(let i=0; i<preSessionQuestionList.length; i++){
   if(preSessionQuestionList[i].type=="text"){
      preSessionQuestionList[i]=new TextQuestion(preSessionQuestionList[i].question, "text");
   }
   else if(preSessionQuestionList[i].type=="bullet"){
      preSessionQuestionList[i]=new BulletQuestion(preSessionQuestionList[i].question, "bullet");
   }
 }

 for(let i=0; i<postSessionQuestionList.length; i++){
   if(postSessionQuestionList[i].type=="text"){
      postSessionQuestionList[i]=new TextQuestion(postSessionQuestionList[i].question, "text");
   }
   else if(postSessionQuestionList[i].type=="bullet"){
      postSessionQuestionList[i]=new BulletQuestion(postSessionQuestionList[i].question, "bullet");
   }
 }
 



 export {Question, preSessionQuestionList, postSessionQuestionList}