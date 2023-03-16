//
//  Bullet.swift
//  ALUM
//
//  Created by Jenny Mar on 3/12/23.
//
import SwiftUI

struct Bullet: View {
    var remove: () -> Void
    var data: String

    var body: some View {
        ZStack {
            Text(data)
                .font(Font.custom("Metropolis-Regular", size: 17))
                .lineSpacing(6)
                .lineLimit(5)
                .padding(.init(top: 10.0, leading: 40, bottom: 10.0, trailing: 32))
                .frame(width: 358, alignment: .leading)
                .background(Color.white)
                .cornerRadius(8)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.init(top: 4.0, leading: 0, bottom: 4.0, trailing: 0))
            HStack {
                Image(systemName: "circle.fill")
                    .frame(width: 8, height: 8)
                    .font(.system(size: 8.0))
                    .foregroundColor(Color("ALUM Dark Blue"))
                    .padding(.init(top: 0.0, leading: 32, bottom: 0.0, trailing: 157))
                Spacer()
                Button {
                    remove()
                } label: {
                    Image(systemName: "xmark")
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color("NeutralGray3"))
                        .font(.system(size: 12))

                    }
                .padding(.init(top: 0.0, leading: 157, bottom: 0.0, trailing: 28))
            }
        }
    }
}

struct BulletsView: View {
    @State var bullets: [String] = []
    @State var showingSheet = false
    @State var newText = ""
    @State var editingBulletIndex = 0

    func cancel() {
        showingSheet = false
    }
    func done() {
        bullets[editingBulletIndex] = newText
        showingSheet = false
    }
    func editText(index: Int) {
        editingBulletIndex = index
        newText = bullets[editingBulletIndex]
        showingSheet = true
    }
    func removeBullet(index: Int) {
        bullets.remove(at: index)
    }
    func addBullet() {
        bullets.append("")
        editingBulletIndex = bullets.count - 1
        newText = ""
        showingSheet = true
    }

    var body: some View {
      // NavigationView {
            ZStack {
                Color("ALUM White 2")
                VStack {
                    ForEach(bullets.indices, id: \.self) { idx in
                        Bullet(
                            remove: {self.removeBullet(index: idx)},
                            data: bullets[idx]
                        )
                        .onTapGesture {
                            self.editText(index: idx)
                        }
                    }
                    CircleAddButton(add: addBullet)
                        .padding(.top, 32)
                    if (bullets.count == 0) {
                        Text("Add topic")
                            .foregroundColor(Color("ALUM Dark Blue"))
                            .font(Font.custom("Metropolis-Regular", size: 17))
                    }
                    Spacer()
                }.sheet(isPresented: $showingSheet) {
                    DrawerContainer(cancelFunc: cancel, doneFunc: done) {
                        ParagraphInput(question: "What topic(s) would you like to discuss?", text: $newText)
                    }
                }
     //      }
       }
    }
}

struct Bullet_Previews: PreviewProvider {
    static var previews: some View {
        BulletsView()
    }
}
