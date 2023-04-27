//
//  NavigationFooter.swift
//  ALUM
//
//  Created by Yash Ravipati on 4/8/23.
//

import SwiftUI

func goMentorProfile(uID: String) {
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       let window = windowScene.windows.first {
        window.rootViewController = UIHostingController(rootView: MentorProfileView(uID: uID))
        window.makeKeyAndVisible()
    }
}

func goMenteeProfile(uID: String) {
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       let window = windowScene.windows.first {
        window.rootViewController = UIHostingController(rootView: MenteeProfileView(uID: uID))
        window.makeKeyAndVisible()
    }
}

func goHome() {
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       let window = windowScene.windows.first {
        window.rootViewController = UIHostingController(rootView: MentorProfileView())
        window.makeKeyAndVisible()
    }
}

struct NavigationFooter: View {
    @State var page: String
    @State var role: String
    @State var uID: String
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 82)
                .foregroundColor(.white)
            HStack {
                ZStack {
                    if page == "Home"{
                        RoundedRectangle(cornerRadius: 8.0)
                            .frame(width: 64, height: 3)
                            .foregroundColor(Color("ALUM Primary Purple"))
                            .offset(y: -35)
                    }
                    Button {
                        if(page != "Home") {
                            goHome()
                        }
                    } label: {
                        VStack {
                            Image("ALUM Home")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 27)
                                .foregroundColor(Color("ALUM Primary Purple"))
                            Text("Home")
                        }
                        .font(.custom("Metropolis-Regular", size: 10, relativeTo: .caption2))
                    }
                    .foregroundColor(Color("ALUM Primary Purple"))
                }
                .padding(.leading, page == "Home" ? 82 : 98)
                Spacer()
                ZStack {
                    if page == "Profile"{
                        RoundedRectangle(cornerRadius: 8.0)
                            .frame(width: 64, height: 3)
                            .foregroundColor(Color("ALUM Primary Purple"))
                            .offset(y: -35)
                    }
                    Button {
                        if(page != "Profile"){
                            if(role == "mentor"){
                                goMentorProfile(uID: uID)
                            }
                            else{
                                goMenteeProfile(uID: uID)
                            }
                        }
                    } label: {
                        VStack {
                            Image("ALUMLogoBlue")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 27, height: 27)
                            Text("Profile")
                        }
                        .font(.custom("Metropolis-Regular", size: 10, relativeTo: .caption2))
                    }
                    .foregroundColor(Color("ALUM Primary Purple"))
                }
                .padding(.trailing, page == "Profile" ? 82 : 93)
            }
            .padding(.bottom, 25)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.bottom  )
    }
}

struct NavigationFooter_Previews: PreviewProvider {
    static var previews: some View {
        NavigationFooter(page: "Home", role: "mentor", uID: "6431b9a2bcf4420fe9825fe5")
    }
}

