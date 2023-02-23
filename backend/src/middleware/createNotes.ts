import preSessionQuestions from "../models/preQuestionsList.json"
import postSessionQuestions from "../models/postQuestionsList.json"
import { assert } from "console";

class Answer {
    answer: string | Array<String>;
    type: string;
    id: number; //hashed from question
    constructor(type: string, id : number) {
        this.answer = "";
        this.type = type;
        this.id = id;
    }

    setAnswer(input: string): void {
        if (typeof this.answer === "string") {
          this.answer = input;
        } else {
          assert(Array.isArray(this.answer));
          this.answer.push(input);
        }
      }
}

function hashCode(str: string) {
    let hash = 0;
    for (let i = 0, len = str.length; i < len; i++) {
        let chr = str.charCodeAt(i);
        hash = (hash << 5) - hash + chr;
        hash |= 0; // Convert to 32bit integer
    }
    return hash;
}

/*
* Hash all questions
*/


function createPreAnswerArray(){
    var preAnswerList:Answer[] = new Array(preSessionQuestions.length);
    for(let i=0; i<preAnswerList.length; ++i){
       preSessionQuestions[i].id = (hashCode(preSessionQuestions[i].question + preSessionQuestions[i].type));
       preAnswerList[i]=new Answer(preSessionQuestions[i]['type'], preSessionQuestions[i]['id']);
    }
    return preAnswerList
}

function createPostAnswerArray(){
    var postAnswerList:Answer[] = new Array(postSessionQuestions.length);
    for(let i=0; i<postAnswerList.length; ++i){
        postSessionQuestions[i].id = (hashCode(postSessionQuestions[i].question + postSessionQuestions[i].type));
        postAnswerList[i]=new Answer(postSessionQuestions[i]['type'], postSessionQuestions[i]['id']);
     }
     return postAnswerList;
}

export { createPreAnswerArray, createPostAnswerArray, Answer}