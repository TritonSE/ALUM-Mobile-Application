//
//  NavigationFooter.swift
//  ALUM
//
//  Created by Yash Ravipati on 4/8/23.
//

import SwiftUI
enum FooterTabs {
    case home
    case profile
}

struct NavigationFooter: View {
    @Binding var page: FooterTabs
    var body: some View {
        ZStack {
            HStack {
                ZStack {
                    if page == .home {
                        RoundedRectangle(cornerRadius: 8.0)
                            .frame(width: 64, height: 3)
                            .foregroundColor(Color("ALUM Primary Purple"))
                            .offset(y: -35)
                    }
                    Button {
                        page = .home
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
                .padding(.leading, page == .home ? 82 : 98)
                Spacer()
                ZStack {
                    if page == .profile {
                        RoundedRectangle(cornerRadius: 8.0)
                            .frame(width: 64, height: 3)
                            .foregroundColor(Color("ALUM Primary Purple"))
                            .offset(y: -35)
                    }
                    Button {
                        page = .profile
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
                .padding(.trailing, page == .profile ? 82 : 93)
            }
        }
        .edgesIgnoringSafeArea(.bottom  )
    }
}

struct NavigationFooterPreviewHelper: View {
    @State var page: FooterTabs = .home
    
    var body: some View {
        NavigationFooter(page: $page)
    }
}

struct NavigationFooter_Previews: PreviewProvider {
    static var previews: some View {
        NavigationFooterPreviewHelper()
    }
}
