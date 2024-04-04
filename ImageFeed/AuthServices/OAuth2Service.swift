//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Dmitry on 03.04.2024.
//

import UIKit

final class OAuth2Service {
    static let shared = OAuth2Service()
    private init() {}
    
    func urlRequestToken(code:String) -> URLRequest {
        guard var components = URLComponents(string: Constants.authToken) //собираем наш url согл документации
        else { preconditionFailure("url error")}
        components.queryItems =
        [URLQueryItem(name: "client_id", value: Constants.accessKey),
         URLQueryItem(name: "client_secret", value: Constants.secretKey),
         URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
         URLQueryItem(name: "code", value: "code"),
         URLQueryItem(name: "grant_type", value: "authorization_code")]
        
        guard let url = components.url  else {
            preconditionFailure("url request error")}
            var request = URLRequest(url:url)
            request.httpMethod = "POST" // меняем get запрос на  post
            return request
        }
        func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
            completion(.success("")) // функция для запроса токена
            let request = urlRequestToken(code: code)
           
            let decTask = URLSession.shared.data(for: request) { result in
                switch result {
                case .success(let data):
                    do {
                        let oauthToken = try JSONDecoder().decode(OAuthTokenResponseBody.self, from:data)
                        guard let accessToken = oauthToken.accesToken else {
                            fatalError("empty")
                        }
                        completion(.success(accessToken))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            decTask.resume()
        }
    
}
