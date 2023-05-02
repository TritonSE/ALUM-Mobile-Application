//
//  LoadingView.swift
//  ALUM
//
//  Created by Aman Aggarwal on 5/1/23.
//

import SwiftUI

// This is temporary for development
struct LoadingView: View {
    var text: String
    
    var body: some View {
        VStack {
            Text(text)
            ProgressView()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(text: "Some View")
    }
}
