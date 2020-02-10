//
//  ViewController.swift
//  WKWebKit
//
//  Created by hongjuyeon_dev on 2020/02/10.
//  Copyright © 2020 hongjuyeon_dev. All rights reserved.
//
// ref
// https://mrgamza.tistory.com/425
// https://mrgamza.tistory.com/490
// https://g-y-e-o-m.tistory.com/13
// https://benoitpasquier.com/ios-webkit-swift-and-javascript/


import UIKit
import WebKit

class ViewController: UIViewController {
    
    var webView: WKWebView!
    
    private func setupWebView() {
        // 연동을 위한 변수선언
        let contentController = WKUserContentController()
        let config = WKWebViewConfiguration()
        
        // native -> js call (html 시작에만 가능. 환경설정 용도로 사용. source 부분에 함수 대신 html 직접 삽입 가능)
        // document 로딩이 끝나고 mobileHeader() 함수가 호출됨.
        let userScript = WKUserScript(source: "mobileHeader()",
                                      injectionTime: .atDocumentEnd,
                                      forMainFrameOnly: true)
        contentController.addUserScript(userScript)
        
        // native에서 일반적으로 js 호출
//        webView.evaluateJavaScript("getLocal()", completionHandler: { (result, error) in
//            if let result = result {
//                print(result)
//            }
//        })
        
        // 공통 작업
        config.userContentController = contentController
        
        
        // js -> native
        // name에 값을 지정해서 js에서 webkit.messageHandlers.NAME.postMessage("")와 연동
        // 즉 js에서 webkit.messageHandlers.callbackHandler.postMessage("")를 호출하면 네이티브 호출 가능
        // userContentController에서 처리
        contentController.add(self, name: "loginAction")
        
        webView = WKWebView(frame: self.view.bounds, configuration: config)
//        webView.uiDelegate = self
//        webView.navigationDelegate = self
        self.view.addSubview(webView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        
        if let url = URL(string: "http://localhost:3000/main") {
            let request = URLRequest(url: url)
            self.webView.load(request)
            print("request url")
        }
    }
}

//extension ViewController: WKNavigationDelegate {
//
//}
//
//extension ViewController: WKUIDelegate {
//
//}

extension ViewController: WKScriptMessageHandler {
    // js -> native
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "loginAction" {
            let message = message.body as? String ?? ""
            // message.body안에 있는 내용을 검사해서 네이티브 함수를 호출
            print("Javascript is sending a message: \(message)")
        }
    }
}
