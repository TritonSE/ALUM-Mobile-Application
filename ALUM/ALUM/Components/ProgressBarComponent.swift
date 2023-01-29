//
//  ProgressBarComponent.swift
//  ALUM
//
//  Created by Yash Ravipati on 1/25/23.
//

// nodeList - [completed, not completed, completed...]

import SwiftUI

struct ProgressBarComponent: View{
    @State var Nodes = 6
    @State var filledNodes = 4
    @State var activeNode = 1
    
    
    
    var body: some View {
        ZStack{
            HStack{
                ForEach(0 ..< Nodes - 1, id:\.self){ index in
                    if(index < activeNode-1 || index < filledNodes - 1){
                        Rectangle()
                            .frame(width: 350/(Double(Nodes) - 1) - 5, height: 2)
                            .foregroundColor(Color("ALUM Dark Blue"))
                    }
                    else{
                        Rectangle()
                            .frame(width: 350/(Double(Nodes) - 1) - 5, height: 2)
                            .foregroundColor(Color("NeutralGray2"))
                    }
                }
            }
            HStack{
                ForEach(0 ..< Nodes, id:\.self){ index in
                    if(index == activeNode - 1){
                        Circle()
                            .strokeBorder(Color("ALUM Dark Blue"),lineWidth: 3)
                            .background(Circle().foregroundColor(Color("ALUM Light Blue")))
                            .frame(width: 16, height: 16)
                            .padding(.horizontal, 170 / (Double(Nodes - 1)) - (5 + Double(Nodes)))
                    }
                    else if (index < filledNodes){
                        ZStack {
                            Circle()
                                .foregroundColor(Color("ALUM Dark Blue"))
                                .frame(width: 16, height: 16)
                                .padding(.horizontal, 170 / (Double(Nodes - 1)) - (5 + Double(Nodes)))
                            
                            Image("CheckMarkVector")
                        }
                    }
                    else{
                        Circle()
                            .foregroundColor(Color("NeutralGray2"))
                            .frame(width: 16, height: 16)
                            .padding(.horizontal, 170 / (Double(Nodes - 1)) - (5 + Double(Nodes)))
                    }
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
