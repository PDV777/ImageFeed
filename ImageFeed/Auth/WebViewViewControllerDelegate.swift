//
//  WebViewViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Dmitry on 02.04.2024.
//

import Foundation

protocol WebViewControllerDelegate:AnyObject {
    func webViewController(_ vc:WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc:WebViewViewController)
    
}
