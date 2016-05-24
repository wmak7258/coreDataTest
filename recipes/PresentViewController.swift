//
//  PresentViewController.swift
//  recipes
//
//  Created by mobileapps on 5/21/16.
//  Copyright © 2016 mobileapps. All rights reserved.
//

import UIKit

class PresentViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var receive = Entity()
    override func viewDidLoad() {
        super.viewDidLoad()
    webView.delegate = self
    let url = NSURL(string: receive.address!)
    let request = NSURLRequest(URL: url!)
    webView.loadRequest(request)
    activity.hidesWhenStopped = true
    }
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        activity.startAnimating()
        return true
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        activity.stopAnimating()
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        activity.stopAnimating()
    }
    

    
}
