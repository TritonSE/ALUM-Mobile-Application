//
//  CalendlyBooking.swift
//  ALUM
// This is a file used to store a dummy button for testing functionality of
// booking an event via calendly. Note that the majority of the code in here will be transferred to
// the profile view code once the PR has been updated
//
//  Created by Adhithya Ananthan on 4/12/23.
//

import Foundation
import SwiftUI
import WebKit


struct CalendlyBooking: View  {
    @State public var showWebView = false
    public var urlString: String = "https://calendly.com/aananthanregina/30min"
    
    var body: some View {
        VStack(spacing: 0) {
            Button {
                showWebView.toggle()
                print("Button Pushed")
            }
            label: {
                Text("View My Calendly")
                .font(Font.custom("Metropolis-Regular", size: 17, relativeTo: .headline))
            }
            .sheet(isPresented: $showWebView) {
                CalendlyView(url: URL(string: urlString)!)
            }
            .buttonStyle(FilledInButtonStyle())
            .frame(width: 358)
            .padding(.bottom, 26)
        }
    }
    
}

struct CalendlyView: UIViewRepresentable {
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let userContentController = WKUserContentController()
        userContentController.add(context.coordinator, name: "message")
        webView.configuration.userContentController = userContentController
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        var parent: CalendlyView
        
        init(_ parent: CalendlyView) {
            self.parent = parent
        }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            print("I got to the userContentController Function")
        }
    }
}

struct CalendlyBooking_Previews: PreviewProvider {
    
    static var previews: some View {
        CalendlyBooking()
    }
}
