//
//  DevelopmentModels.swift
//  ALUM
//
//  Created by Aman Aggarwal on 5/22/23.
//

import Foundation

class DevelopmentModels {
    static var sessionModel: SessionModel = SessionModel(
        preSession: "6464276b6f05d9703f069761", 
        postSessionMentee: Optional("6464276b6f05d9703f069763"), 
        postSessionMentor: Optional("6464276b6f05d9703f069765"), 
        menteeId: "6431b99ebcf4420fe9825fe3", 
        mentorId: "6431b9a2bcf4420fe9825fe5", 
        menteeName: "Mentee Name",
        mentorName: "Mentor Name",
        fullDateString: "Thursday, May 18, 2023",
        dateShortHandString: "5/18",
        startTimeString: "11:00 AM",
        endTimeString: "11:30 AM",
        preSessionCompleted: true, 
        postSessionMenteeCompleted: false, 
        postSessionMentorCompleted: false, 
        hasPassed: false, 
        location: "https://alum.zoom.us/my/timby"
    )
    
    static var menteeModel: MenteeInfo = MenteeInfo(
        id: "6431b99ebcf4420fe9825fe3", 
        name: "Mentee", 
        imageId: "640b86513c48ef1b07904241", 
        about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", 
        grade: 9, 
        topicsOfInterest: ["computer science"], 
        careerInterests: ["software development"], 
        mentorshipGoal: nil, 
        mentorId: nil, 
        status: nil, 
        whyPaired: Optional("Modified Why Paired")
    )
    
    static var postSessionFormModel: [Question] = [
        Question(
            question: "What topics did you discuss?", 
            type: "bullet", 
            id: "4cb4504d3308126edee7ef72b7e04a04db8a1f5d45f8137fcb2717a33515de8b", 
            answerBullet: [], 
            answerCheckboxBullet: [], 
            answerParagraph: ""
        ), 
        Question(
            question: "Key takeaways from the session:", 
            type: "bullet", 
            id: "53f0ce23b3cb957455ded4c35a1fc7047b2365174b0cf05d2e945a31fde0d881", 
            answerBullet: ["Sasdlkfna;slkdfasdf;a"], 
            answerCheckboxBullet: [], 
            answerParagraph: ""
        ), 
        Question(
            question: "Next step(s):", 
            type: "bullet", 
            id: "6e4e9e6195735e254e25a9663977ccb51255717f0880726899788375b21e2c30", 
            answerBullet: [], 
            answerCheckboxBullet: [], 
            answerParagraph: ""
        ), 
        Question(
            question: "Other notes:", 
            type: "text", 
            id: "fc58a4a3bfb853c240d3b9854695a7057d022a3b4dc1ec651cd0b9e2ef88ae8e", 
            answerBullet: [], 
            answerCheckboxBullet: [], 
            answerParagraph: ""
        )
    ]
    
    static var preSessionFormModel: [Question] = [
        Question(
            question: "What topic(s) would you like to discuss?", 
            type: "bullet", 
            id: "3486cca0ff5e75620cb5cded01041c45751d0ac93a068de3f4cd925b87cdff5f", 
            answerBullet: [], 
            answerCheckboxBullet: [], 
            answerParagraph: ""
        ), 
        Question(
            question: "Do you have any specifc question(s)?", 
            type: "bullet", 
            id: "f929836eee49ca458ae32ad89164bdb31e5749a5606c15b147a61d69c7cac8fd", 
            answerBullet: [], 
            answerCheckboxBullet: [], 
            answerParagraph: ""
        ), 
        Question(
            question: "Anything else that you want your mentor to know?", 
            type: "text", 
            id: "9bb08261232461b5dfbdea48578c6054adf7fd8639d815b4143080d0c16ec590", 
            answerBullet: [], 
            answerCheckboxBullet: [], 
            answerParagraph: ""
        )
    ]
}
