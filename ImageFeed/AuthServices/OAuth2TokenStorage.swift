import UIKit
import SwiftKeychainWrapper

final class OAuth2TokenStorage {
   private let tokenKey = "bearerAccessToken"
//    private let keychainWrapper = KeychainWrapper.standard
//     var token: String? {
//        get {
//            keychainWrapper.string(forKey:tokenKey)
//        }
//        set {
//            guard let token = newValue  else { return }
//            keychainWrapper.set(token, forKey:tokenKey)
//        }
                    private let userDefaults = UserDefaults.standard
                    var token: String? {
                        get {
                            userDefaults.string(forKey: "bearerAccessToken")
                        }
                        set {
                            userDefaults.setValue(newValue, forKey: "bearerAccessToken")
                        }
                    }
    }

//перечитать про keyChain по поводу удаления кеша !!!! перечитал

//let removeSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: "bearerAccessToken") это удаляет токен
