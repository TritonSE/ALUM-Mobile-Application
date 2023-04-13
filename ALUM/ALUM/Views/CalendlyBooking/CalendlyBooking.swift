//
//  CalendlyBooking.swift
//  ALUM
// This is a file used to store a dummy button for testing functionality of
// booking an event via calendly. Note that the majority of the code in here will be transferred to
// the profile view code once the PR has been updated
//
//  Created by Adhithya Ananthan on 4/12/23.
//

import Foundation
import SwiftUI


struct CalendlyBooking: View  {
    
    var body: some View {
        VStack(spacing: 0) {
            Button {
                
            } label: {
                Text("View My Calendly")
                .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
            }
            .buttonStyle(FilledInButtonStyle())
            .frame(width: 358)
            .padding(.bottom, 26)
        }
    }
}

struct CalendlyBooking_Previews: PreviewProvider {
    
    static var previews: some View {
        CalendlyBooking()
    }
}
