//
//  BrowserViewController.swift
//  KuTing
//
//  Created by Maynard on 2018/3/12.
//  Copyright © 2018年 RayboWallet. All rights reserved.
//

import UIKit
import WebKit

class BrowserViewController: UIViewController {
    
    var url: URL? {
        didSet {
            loadURL()
        }
    }

    var webView: WKWebView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    func loadURL() {
        guard let url = url else {
            return
        }
        HUD.loading(text: "")
        let request = URLRequest(url: url)
        webView.load(request)
        webView.navigationDelegate = self
    }
    
    deinit {
        HUD.hideLoading()
    }
}

extension BrowserViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        HUD.showError(error: error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        HUD.hideLoading()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
}
