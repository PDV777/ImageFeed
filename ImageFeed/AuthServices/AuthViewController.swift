//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Dmitry on 29.03.2024.
//

import UIKit

class AuthViewController:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackButton()
    }
    
    private func configureBackButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "NavBackButton")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "NavBackButton")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor(named: "YP Black")
    }
}
extension AuthViewController: WebViewViewControllerDelegate {
    func webViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {

    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {

    }
    
    
}
