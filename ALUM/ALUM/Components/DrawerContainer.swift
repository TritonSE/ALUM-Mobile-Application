//
//  DrawerContainer.swift
//  ALUM
//
//  Created by Jenny Mar on 2/17/23.
//
import SwiftUI

struct DrawerContainer<Content: View>: View {
    var cancelFunc: () -> Void
    var doneFunc: () -> Void
    @ViewBuilder var content: Content

    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 16)
                    .frame(height: UIScreen.main.bounds.height * 0.9)
                    .foregroundColor(Color.white)
                VStack {
                    HStack {
                        Button("Cancel") {
                            withAnimation(.spring()) {
                                cancelFunc()
                            }
                        }
                        .foregroundColor(Color("ALUM Dark Blue"))
                        .font(.system(size: 13))
                        Spacer()
                        Button("Done") {
                            withAnimation(.spring()) {
                                doneFunc()
                            }
                        }
                        .foregroundColor(Color("ALUM Dark Blue"))
                        .font(.system(size: 13))
                    }
                    .padding(.bottom, 20)
                    .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .center)
                    content
                }.padding(20)
            }.transition(.move(edge: .bottom))
        }
    }
}

struct DrawerTester: View {
    @State private var showingSheet = false
    @State var data: String = "previous text"
    @State var oldText: String = "previous text"

    var body: some View {
        NavigationView {
            VStack {
                Button("open drawer") {
                    showingSheet.toggle()
                }
                .padding(120)
                .background(Color("ALUM White"))
                .foregroundColor(Color.black)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color("NeutralGray3"), lineWidth: 1))
                .sheet(isPresented: $showingSheet) {
                    DrawerContainer(cancelFunc: cancel, doneFunc: done) {
                        ParagraphInput(question: "Why do you want to be a mentor?", text: $data)
                    }
                }

                Text(data)
            }
        }
    }

    func done() {
        oldText = data
        showingSheet = false
    }

    func cancel() {
        data = oldText
        showingSheet = false
    }
}

struct DrawerContainer_Previews: PreviewProvider {
    static var previews: some View {
        DrawerTester()
    }
}
