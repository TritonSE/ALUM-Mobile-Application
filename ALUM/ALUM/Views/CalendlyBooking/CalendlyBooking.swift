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
    var requestType: String
    var sessionId: String = ""

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.configuration.userContentController.add(context.coordinator, name: "calendlyURI")
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        let route = APIRoute.getCalendly
        Task {
            do {
                let request = try await route.createURLRequest()
                uiView.load(request)
            } catch {
                throw AppError.internalError(.unknownError, message: "Error Loading Calendly Link")
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(webView: self, requestType: requestType, sessionId: sessionId)
    }

    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {

        var webView: CalendlyView
        var requestType: String
        var sessionId: String

        init(webView: CalendlyView, requestType: String, sessionId: String) {
            self.webView = webView
            self.requestType = requestType
            self.sessionId = sessionId
        }

        func userContentController(_ userContentController: WKUserContentController,
                                   didReceive message: WKScriptMessage) {
            if message.name == "calendlyURI" {
                if(requestType == "POST") {
                    Task {
                        do {
                            let messageBody = "\(message.body)"
                            let result = try await
                            SessionService().postSessionWithId(calendlyURI: messageBody)
                            DispatchQueue.main.async {
                                CurrentUserModel.shared.isLoading = true
                            }
                        } catch {
                            throw AppError.internalError(.unknownError, message: "Error posting a new session")
                        }
                    }
                }
                if(requestType == "PATCH") {
                    Task {
                        do {
                            let messageBody = "\(message.body)"
                            let resule = try await
                            SessionService().patchSessionWithId(sessionId: sessionId,
                                                                newCalendlyURI: messageBody)
                            DispatchQueue.main.async {
                                CurrentUserModel.shared.isLoading = true
                            }
                        } catch {
                            throw AppError.internalError(.unknownError, message: "Error updating a session")
                        }
                    }
                }
            }
        }
    }

}
