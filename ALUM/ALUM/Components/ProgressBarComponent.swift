//
//  ProgressBarComponent.swift
//  ALUM
//
//  Created by Yash Ravipati on 1/25/23.
//

// nodeList - [completed, not completed, completed...]

import SwiftUI

struct ProgressBarComponent: View{
    @State var filledNodes = 2
    
    var body: some View {
        HStack{
            Group{
                ForEach(0 ..< filledNodes, id:\.self) { index in
                    Circle()
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color("ALUM Dark Blue"))
                }
                .frame(maxWidth: .infinity)
            }
        }
        
    }
}

struct ProgressBarComponent_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarComponent()
    }
}
