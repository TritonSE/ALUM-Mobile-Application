import preSessionQuestions from "../models/preQuestionsList.json"
import postSessionQuestions from "../models/postQuestionsList.json"
import { assert } from "console";
import { Note }from "../models/notes"

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


async function createPreSessionNotes() {
    let preNotes=null;
    try{
        const preSessionAnswers= createPreAnswerArray()
        preNotes = new Note({preSessionAnswers, type : "pre" });
        const postSessionAnswers= createPostAnswerArray()
        const postSessionNotes = new Note({postSessionAnswers, type : "post" });
        return await preNotes.save()    
    }
    catch(e) {
        throw Error;
    }
}

async function createPostSessionNotes() {
    let postNotes=null;
    try{
        const postSessionAnswers=createPostAnswerArray()
        postNotes = new Note({postSessionAnswers, type : "post" });
        return postNotes.save()
    }
    catch(e) {
        throw Error;
    }
}

export {createPreSessionNotes, createPostSessionNotes}