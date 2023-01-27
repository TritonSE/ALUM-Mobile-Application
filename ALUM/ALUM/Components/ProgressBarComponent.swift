//
//  ProgressBarComponent.swift
//  ALUM
//
//  Created by Yash Ravipati on 1/25/23.
//

// nodeList - [completed, not completed, completed...]

import SwiftUI

struct ProgressBarComponent: View{
    @State var filledNodes = 4
    
    
    
    var body: some View {
        ZStack{
            HStack{
                ForEach(0 ..< filledNodes - 1, id:\.self){ _ in
                    Rectangle()
                        .frame(width: 375/(Double(filledNodes) - 1) - 5, height: 2)
                        .foregroundColor(Color("ALUM Dark Blue"))
                }
            }
            HStack{
                ForEach(0 ..< filledNodes, id:\.self){ _ in
                    Circle()
                        .strokeBorder(Color("ALUM Dark Blue"),lineWidth: 3)
                            .background(Circle().foregroundColor(Color("ALUM Light Blue")))
                        .frame(width: 16, height: 16)
                        .padding(.horizontal, 175 / (Double(filledNodes - 1)) - (5 + Double(filledNodes)))
                }
            }
        }
    }
}

struct ProgressBarComponent_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarComponent()
    }
}
