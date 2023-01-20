//
// Outlined Button View.swift
// ALUM
//
// Created by Jenny Mar on 1/17/23.
//
import SwiftUI

struct OutlinedButton: ButtonStyle {
    
  @State var isLarge: Bool = true
  @State var disabled: Bool = false
    
  var LargeWidth = 358.0
  var SmallWidth = 104.0
    
  func makeBody(configuration: Configuration) -> some View {
      
    if (!disabled) {
      configuration.label
        .frame(height: 48)
        .frame(width: isLarge ? LargeWidth : SmallWidth)
        .foregroundColor(Color("ALUM Dark Blue"))
        .font(.system(size: 17, weight: .medium))
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color( "ALUM Dark Blue"), lineWidth: 5)
        )
        .cornerRadius(8)
    }
      
    else {
      configuration.label
        .frame(height: 48)
        .frame(width: isLarge ? LargeWidth : SmallWidth)
        .foregroundColor(Color("NeutralGray4"))
        .font(.system(size: 17, weight: .medium))
        .background(Color(
        "NeutralGray1"))
        .cornerRadius(8)
        .disabled(true)
    }
  }
}


struct OutlinedButtonView: View {
 var body: some View {
  Button("Button") {
  }
  .buttonStyle(OutlinedButton(isLarge: true, disabled: false))
 }
}


struct Outlined_Button_View_Previews: PreviewProvider {
  static var previews: some View {
    OutlinedButtonView()
  }
}
