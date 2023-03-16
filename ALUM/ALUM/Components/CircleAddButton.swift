//
//  CircleAddButton.swift
//  ALUM
//
//  Created by Jenny Mar on 3/11/23.
//
import SwiftUI

struct CircleAddButton: View {
    @State var add: () -> Void
    var body: some View {
        ZStack {
            Circle()
                .fill(.white)
                .opacity(0.3)
                .frame(width: 80, height: 80)

           Button {
               add()
           } label: {
               ZStack {
                   Circle()
                       .fill(Color("ALUM Light Blue"))
                       .frame(width: 64, height: 64)
                   Image(systemName: "plus")
                       .foregroundColor(Color("ALUM Dark Blue"))
                       .font(.system(size: 14.0))
               }
           }
        }
    }
}

struct TestAdd: View {
    func add() {

    }
    var body: some View {
        CircleAddButton(add: add)
    }
}

struct Add_Previews: PreviewProvider {
    static var previews: some View {
        TestAdd()
    }
}
