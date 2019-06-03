//
//  WebViewController.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 03/06/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var urlString: String = "https://www.apple.com"
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:urlString)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
}
