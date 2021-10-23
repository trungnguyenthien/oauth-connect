//
//  ViewController.swift
//  OauthConnect
//
//  Created by Trung on 07/10/2021.
//

import UIKit

private let myInfo = OauthInfo(
    clientID: "263198911943-fakodv63vh9p5r8gs2mp15gegsfknbvj.apps.googleusercontent.com",
    clientSecret: "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",
    redirectUri: "com.googleusercontent.apps.263198911943-fakodv63vh9p5r8gs2mp15gegsfknbvj:localhost",
    scopes: ["openid"],
    authEndpoint: "https://accounts.google.com/o/oauth2/v2/auth",
    tokenEndpoint: "https://www.googleapis.com/oauth2/v4/token"
)


import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let web = loginViewController(info: myInfo) {
            web.delegate = self
            present(web, animated: true, completion: nil)
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}


private extension UIView {
    func addStretchToFit(
        subview: UIView,
        left: CGFloat = 0,
        right: CGFloat = 0,
        top: CGFloat = 0,
        bottom: CGFloat = 0
    ) {
        subview.removeFromSuperview()
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: subview.leftAnchor, constant: left).isActive = true
        rightAnchor.constraint(equalTo: subview.rightAnchor, constant: right).isActive = true
        topAnchor.constraint(equalTo: subview.topAnchor, constant: top).isActive = true
        bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: bottom).isActive = true
    }
}
