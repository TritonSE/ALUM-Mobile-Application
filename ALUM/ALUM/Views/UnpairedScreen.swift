//
//  UnpairedScreen.swift
//  ALUM
//
//  Created by Aman Aggarwal on 5/23/23.
//

import SwiftUI

struct UnpairedScreen: View {
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared

    var body: some View {
        VStack {
            Group {
                if currentUser.status == "under review" {
                    if currentUser.role == .mentee {
                        LoginReviewPage(text:
                                            ["Application is under review",
                                               "It usually takes 3-5 days to process your application as a mentee."])
                    } else if currentUser.role == .mentor {
                        LoginReviewPage(text:
                                            ["Application is under review",
                                               "It usually takes 3-5 days to process your application as a mentor."])
                    }
                } else if currentUser.status == "approved" {
                    if currentUser.role == .mentee {
                        LoginReviewPage(text:
                                            ["Matching you with a mentor",
                                               "We are looking for a perfect mentor for you. Please allow us some time!"])
                    } else if currentUser.role == .mentor {
                        LoginReviewPage(text:
                                            ["Matching you with a mentee",
                                               "We are looking for a perfect mentee for you. Please allow us some time!"])
                    }
                }
            }
            logOutButton
        }
    }
    
    private var logOutButton: some View {
        Button(action: {
            FirebaseAuthenticationService.shared.logout()
        }, label: {
            HStack {
                ALUMText(text: "Log out", textColor: ALUMColor.red)
                Image("Logout Icon")
            }
        })
        .buttonStyle(FullWidthButtonStyle())
    }
}

struct UnpairedScreen_Previews: PreviewProvider {
    static var previews: some View {
        UnpairedScreen()
    }
}
