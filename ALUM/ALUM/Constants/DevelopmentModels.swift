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
