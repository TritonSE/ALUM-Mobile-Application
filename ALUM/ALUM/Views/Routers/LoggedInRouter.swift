//
//  CustomTabView.swift
//  ALUM
//
//  Created by Aman Aggarwal on 5/1/23.
//

import SwiftUI

// Contains the custom tab view
struct LoggedInRouter: View {
    @ObservedObject var currentUser: CurrentUserModel = CurrentUserModel.shared

    @State private var selection: Int
    
    init(defaultSelection: Int = 0) {
        UITabBar.appearance().backgroundColor = UIColor(Color.white) // custom color.
        selection = defaultSelection
    }

    let tabItems = [
            TabBarItem(iconName: "ALUM Home", title: "Home"),
            TabBarItem(iconName: "GrayCircle", title: "Profile")
        ]
    
    // once user is approved and paired
    var body: some View {
        return ZStack(alignment: .bottom) {
            // Turns out for preference keys to work you need to run the mutate preference key function from either the view directly
            // inside the navigation view OR from an inner view which is traversed last. 
            // Swift runs the preference key functions in a DFS manner. That's why we had to display the tab bar this way so that content is
            // the last item traversed
            VStack {
                Spacer()
                if currentUser.showTabBar {
                    tabsDisplay
                }
            }
            content
                .padding(.bottom, 50)
        }
    }
    
    var content: some View {
        VStack(spacing: 0) {
            
            Group {
                switch selection {
                case 0:
                    HomeTabRouter()
                case 1:
                    ProfileTabRouter()
                        .customNavigationIsHidden(true) // We shall use our own header component here so that we can easily add the edit buttons
                default:
                    Text("Error")
                }
                
            }
            .onAppear(perform: { 
                currentUser.showTabBar = true
            })
            .onDisappear(perform: {
                currentUser.showTabBar = false
            })
        }
    }
    
    var tabsDisplay: some View {
        ZStack(alignment: .bottom) {
            HStack(spacing: 0) {
                ForEach(0..<tabItems.count) { index in
                    VStack(spacing: 0) {
                        if index == selection {
                            Rectangle()
                                .frame(width: 64, height: 3)
                                .foregroundColor(Color("ALUM Primary Purple"))
                        } else {
                            Rectangle()
                                .frame(width: 64, height: 2)
                                .foregroundColor(.white)
                        }
                        Button(action: {
                            selection = index
                        }, label: {
                            VStack(spacing: 4) {
                                Image( tabItems[index].iconName)
                                    .font(.system(size: 20))
                                Text(tabItems[index].title)
                                    .font(.custom("Metropolis-Regular", size: 10, relativeTo: .footnote))
                            }
                            .foregroundColor(Color("ALUM Primary Purple"))
                            .frame(maxWidth: .infinity)
                        })
                        .padding(.top, 15)
                    }
                }
            }
            .frame(height: 45)
        }
    }
}

struct TabBarItem {
    let iconName: String
    let title: String
}

struct LoggedInRouter_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInRouter()
    }
}
