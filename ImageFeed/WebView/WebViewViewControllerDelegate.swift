import Foundation
import UIKit

protocol WebViewViewControllerDelegate:AnyObject {
    
    func webViewController(_ vc:WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc:WebViewViewController)
    
}
