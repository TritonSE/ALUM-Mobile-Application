//
//  LoggedOutRouter.swift
//  ALUM
//
//  Created by Aman Aggarwal on 4/14/23.
//

import SwiftUI

struct LoggedOutRouter: View {
    @EnvironmentObject var appEnvironment: AppEnvironment

    var body: some View {
        LoginPageView()
    }
}

struct LoggedOutRouter_Previews: PreviewProvider {
    static var previews: some View {
        LoggedOutRouter()
    }
}
