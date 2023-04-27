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
    @State var type: String = "bullet"
    @State var checked: Bool = false

    func toggleType() {
        if type == "checked" {
            type = "unchecked"
        } else if type == "unchecked" {
            type = "checked"
        }
    }

    var body: some View {
        if type == "bullet" {
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
                    .padding(.init(top: 8.0, leading: 0, bottom: 8.0, trailing: 0))
                HStack {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 8.0))
                        .foregroundColor(Color("ALUM Dark Blue"))
                        .padding(.init(top: 0.0, leading: 36, bottom: 0.0, trailing: 157))
                    Spacer()
                    Button {
                        remove()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color("NeutralGray3"))
                            .font(.system(size: 12))

                        }
                    .padding(.init(top: 0.0, leading: 157, bottom: 0.0, trailing: 28))
                }
            }
        } else {
            ZStack {
                Text(data)
                    .font(Font.custom("Metropolis-Regular", size: 17))
                    .foregroundColor(checked ? Color(.black) : Color("NeutralGray4"))
                    .lineSpacing(6)
                    .lineLimit(5)
                    .padding(.init(top: 10.0, leading: 40, bottom: 10.0, trailing: 32))
                    .frame(width: 358, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(8)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.init(top: 8.0, leading: 0, bottom: 8.0, trailing: 0))
                HStack {
                    ZStack {
                        if checked == true {
                            Image(systemName: "square.fill")
                                .foregroundColor(Color("ALUM Light Blue"))
                                .padding(.init(top: 0.0, leading: 32, bottom: 0.0, trailing: 157))
                            Image(systemName: "checkmark")
                                .foregroundColor(Color("ALUM Dark Blue"))
                                .font(.system(size: 10, weight: .bold))
                                .padding(.init(top: 0.0, leading: 32, bottom: 0.0, trailing: 157))
                        }
                        Image(systemName: "square")
                            .foregroundColor(Color("ALUM Dark Blue"))
                            .onTapGesture {
                                self.checked.toggle()
                                toggleType()
                            }
                            .padding(.init(top: 0.0, leading: 32, bottom: 0.0, trailing: 157))
                    }
                    Spacer()
                    Button {
                        remove()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color("NeutralGray3"))
                            .font(.system(size: 12))

                        }
                    .padding(.init(top: 0.0, leading: 157, bottom: 0.0, trailing: 28))
                }
            }
        }
    }
}

struct BulletsView: View {
    @Binding var bullets: [String]
    var question: String
    @State var showingSheet = false
    @State var newText = ""
    @State var editingBulletIndex = 0
    @State var belowText: String = "Add topic"

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
       NavigationView {
            ZStack {
                Color("ALUM White 2")
                VStack {
                    ForEach(bullets.indices, id: \.self) { idx in
                        Bullet(
                            remove: {self.removeBullet(index: idx)},
                            data: bullets[idx],
                            type: "bullet"
                        )
                        .onTapGesture {
                            self.editText(index: idx)
                        }
                    }
                    CircleAddButton(add: addBullet)
                        .padding(.top, 32)
                    if bullets.count == 0 {
                        Text(belowText)
                            .foregroundColor(Color("ALUM Dark Blue"))
                            .font(Font.custom("Metropolis-Regular", size: 17))
                    }
                    Spacer()
                }.sheet(isPresented: $showingSheet) {
                    DrawerContainer(cancelFunc: cancel, doneFunc: done) {
                        ParagraphInput(question: question, text: $newText)
                    }
                }
           }
       }
    }
}

struct CheckboxBulletsView: View {
    @Binding var checkboxBullets: [CheckboxBullet]
    @State var question: String
    @State var showingSheet = false
    @State var newText = ""
    @State var editingBulletIndex = 0
    @State var belowText: String = "Add topic"

    func cancel() {
        showingSheet = false
    }
    func done() {
        checkboxBullets[editingBulletIndex].content = newText
        showingSheet = false
    }
    func editText(index: Int) {
        editingBulletIndex = index
        newText = checkboxBullets[editingBulletIndex].content
        showingSheet = true
    }
    func removeBullet(index: Int) {
        checkboxBullets.remove(at: index)
    }
    func addBullet() {
        checkboxBullets.append(CheckboxBullet(content: "", status: "bullet"))
        editingBulletIndex = checkboxBullets.count - 1
        newText = ""
        showingSheet = true
    }

    var body: some View {
       NavigationView {
            ZStack {
                Color("ALUM White 2")
                VStack {
                    ForEach(checkboxBullets.indices, id: \.self) { idx in
                        Bullet(remove: {self.removeBullet(index: idx)},
                               data: checkboxBullets[idx].content,
                               type: checkboxBullets[idx].status,
                               checked: checkboxBullets[idx].status == "checked")
                        .onTapGesture {
                            self.editText(index: idx)
                        }
                    }
                    CircleAddButton(add: addBullet)
                        .padding(.top, 32)
                    if checkboxBullets.count == 0 {
                        Text(belowText)
                            .foregroundColor(Color("ALUM Dark Blue"))
                            .font(Font.custom("Metropolis-Regular", size: 17))
                    }
                    Spacer()
                }.sheet(isPresented: $showingSheet) {
                    DrawerContainer(cancelFunc: cancel, doneFunc: done) {
                        ParagraphInput(question: question, text: $newText)
                    }
                }
           }
       }
    }
}

struct BulletsViewTester: View {
    @State var bulletsList: [CheckboxBullet] = [
        CheckboxBullet(content: "some content", status: "unchecked"),
        CheckboxBullet(content: "more content", status: "bullet"),
        CheckboxBullet(content: "a bullet here", status: "bullet")]
    @State var question: String = "Why do you want to be a mentor?"
    var body: some View {
        CheckboxBulletsView(checkboxBullets: $bulletsList, question: question)
    }
}

struct Bullet_Previews: PreviewProvider {
    static var previews: some View {
        BulletsViewTester()
    }
}
