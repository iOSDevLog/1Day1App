//
//  AIViewController.swift
//  AIDraw
//
//  Created by iOS Dev Log on 2018/2/9.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

import UIKit
import WebKit

class AIViewController: UIViewController {

    @IBOutlet weak var wkWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "https://www.autodraw.com")
        let request = NSURLRequest(url: url! as URL)
        wkWebView.load(request as URLRequest)
    }
}
