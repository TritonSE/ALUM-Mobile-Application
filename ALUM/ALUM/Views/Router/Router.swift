//
//  RouterLoggedIn.swift
//  ALUM
//
//  Created by Aman Aggarwal on 4/14/23.
//

import SwiftUI

struct Router: View {
    @StateObject var appEnvironment = AppEnvironment()

    var body: some View {
        if appEnvironment.isLoggedIn {
            LoggedInRouter()
                .environmentObject(appEnvironment)
        } else {
            LoggedOutRouter()
                .environmentObject(appEnvironment)
        }
    }
}

struct RouterLoggedIn_Previews: PreviewProvider {
    static var previews: some View {
        Router()
    }
}
