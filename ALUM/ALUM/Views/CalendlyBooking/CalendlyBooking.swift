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


struct CalendlyView: UIViewRepresentable {
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.configuration.userContentController.add(context.coordinator, name: "calendlyURI")
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(webView: self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        
        var webView: CalendlyView
        
        init(webView: CalendlyView) {
            self.webView = webView
        }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if message.name == "calendlyURI" {
                Task{
                    do {
                        let messageBody = "\(message.body)"
                        // Method should be called with proper mentor, mentee ids
                        let result = try await
                        SessionService().postSessionWithId(calendlyURI: messageBody)
                            
                    } catch {
                        print("Error Posting session")
                    }
                }
            }
        }
    }
        
}
