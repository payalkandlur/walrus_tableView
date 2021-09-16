//
//  WebViewViewController.swift
//  walrus_assignment
//
//  Created by Payal Kandlur on 15/09/21.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKNavigationDelegate {
    
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var webView: WKWebView!
    var url : URL?
    var titleVal : String?
    var currentUrl: URL?
    var backButton = UIBarButtonItem()
    var forwardButton = UIBarButtonItem()
    var refreshButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        
        refreshButton.isEnabled = false
        webView.navigationDelegate = self
        
        self.titleLabel.text = self.titleVal
        self.loadWebView()
    }
    
    ///This function loads the url on the web view.
    func loadWebView() {
        if let url = self.url {
            webView.load(URLRequest(url: url))
        }
    }
    
    ///This function handles the cancel button action and dismisses the web view.
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        CommonUtils.sharedInstance.hideActivityIndicator()
        refreshButton.isEnabled = true
    }
    
    //start progress on start loading
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        CommonUtils.sharedInstance.showActivityIndicatory(self.view)
    }
    
    //stop progress on failed loading
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        CommonUtils.sharedInstance.hideActivityIndicator()
        let error = error as NSError
        if error.code == -1009 || error.code == -1001 {
            
            let alertController = UIAlertController(title: "Error", message: "Failed to load the web page, try again reconnnecting to the internet", preferredStyle: UIAlertController.Style.alert)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    //added to handle back button navigation
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        CommonUtils.sharedInstance.hideActivityIndicator()
    }
    
}
