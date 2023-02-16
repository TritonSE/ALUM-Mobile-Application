enum AnswerTypes{
    TextBox,
    Bullets,
 }

 interface Question{
    readonly question: string;
    questionType: AnswerTypes;
    answer: string | Array<String>;
    setAnswer(ans : string): void;
 }

 class TextQuestion implements Question{
    readonly question: string;
    questionType: AnswerTypes.TextBox;
    answer: string;
    constructor(question: string){
        this.question=question;
        this.questionType= AnswerTypes.TextBox;
        this.answer= "";
    }

    public setAnswer(ans: string){
        this.answer=ans;
    }
 }

 class BulletQuestion implements Question{
    readonly question: string;
    questionType: AnswerTypes.Bullets;
    answer: Array<String>;
    constructor(question: string){
        this.question=question;
        this.questionType=AnswerTypes.Bullets;
        this.answer=new Array<String>;
    }

    public setAnswer(ans: string){
        this.answer.push(ans);
    }
 }

 function createTextQuestion(question : string){
    return new TextQuestion(question);
 }

 function createBulletQuestion(question : string){
    return new BulletQuestion(question);
 }

 export {Question, AnswerTypes, BulletQuestion, TextQuestion, createTextQuestion, createBulletQuestion}