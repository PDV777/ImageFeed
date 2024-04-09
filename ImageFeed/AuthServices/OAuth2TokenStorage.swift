import UIKit

final class OAuth2TokenStorage {
    private let userDefaults = UserDefaults.standard
    var token:String?{
        get {
           userDefaults.string(forKey: "bearerAccessToken")
        }
        set {
            userDefaults.setValue(newValue, forKey: "bearerAccessToken")
        }
    }
}
