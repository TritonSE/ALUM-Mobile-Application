//
//  Bullet.swift
//  ALUM
//
//  Created by Jenny Mar on 3/12/23.
//

import SwiftUI

struct Bullet: View {
    @State var editText: (Int) -> Void
    @State var remove: (Int) -> Void
    @State var data: String

    var body: some View {
        ZStack {
            Button {
                editText(0)
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
                    .frame(width: 358, height: 42)
            }
            HStack {
                Image(systemName: "circle.fill")
                    .foregroundColor(Color("ALUM Dark Blue"))
                    .font(.system(size: 8.0))
                    .padding(.init(top: 0.0, leading: 32, bottom: 0.0, trailing: 16.0))
                Text(data)
                    .font(.system(size: 17))
                    .lineLimit(4)
                Spacer()
                Button {
                    remove(0)
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color("NeutralGray3"))
                        .font(.system(size: 12))
                        .padding(.init(top: 0.0, leading: 12, bottom: 0.0, trailing: 28))
                }
            }
        }
    }
}

struct BulletView: View {
    @State var bullets: [String] = ["hi", "hello"]
    @State var showingSheet = false
    @State var newText = ""
    @State var idx = 0

    func cancel() {
        showingSheet = false
    }
    func done(str: String) {
        bullets[idx] = newText
        showingSheet = false
    }
    func editText(index: Int) {
        idx = index
        newText = bullets[index]
        showingSheet = true
    }
    func removeBullet(index: Int) {
        bullets.remove(at: index)
    }
    func addBullet() {
        bullets.append("")
        newText = ""
        showingSheet = true
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color("ALUM White2")
                VStack {
                    ForEach(bullets, id: \.self) { str in
                        Bullet(editText: editText, remove: removeBullet, data: str)
                    }
                    CircleAddButton(add: addBullet)
                }.sheet(isPresented: $showingSheet) {
                    DrawerContainer(cancelFunc: cancel, doneFunc: done) {
                        ParagraphInput(question: "What topic(s) would you like to discuss?", text: $newText)
                    }
                }
            }
        }
        
    }
}

struct Bullet_Previews: PreviewProvider {
    static var previews: some View {
        BulletView()
    }
}
