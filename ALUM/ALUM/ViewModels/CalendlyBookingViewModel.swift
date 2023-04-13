//
//  CalendlyBookingViewModel.swift
//  ALUM
//  This file contains helper functions to navigate the calendly
// booking feature
//
//  Created by Adhithya Ananthan on 4/12/23.
//

import Foundation
import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendlyLink = URL(string:"https://calendly.com/aananthanregina/30min")
        let myRequest = URLRequest(url: calendlyLink!)
        webView.load(myRequest)
    }
}
