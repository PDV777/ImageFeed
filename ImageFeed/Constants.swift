//
//  Constants.swift
//  ImageFeed
//
//  Created by Dmitry on 28.03.2024.
//

import UIKit

enum Constants {
    static let accessKey = "S7HfFfXaa4uj8U5RXSfWAndpeABNQi0Jk4ns6mf6xVw"
    static let secretKey = "EffrjfGMyXopM8ajU06LG1k7fr5z-Wun1dWmxM5wS_M"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "Public access" + "Read user access" + "Write likes access"
    static let defaultBaseUrl = URL(string: "https://api.unsplash.com/")
}





//var defaultBaseURL: URL {
//    guard let  url = URL(string: "https://api.unsplash.com/") else {
//        preconditionFailure("Unable to construct mostPopularMoviesUrl")
//    }
//    return url
//    } может сделаю так