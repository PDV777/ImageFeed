import UIKit

enum AuthServiceError {
    case invalidRequest
}

final class OAuth2Service {
    
    static let shared = OAuth2Service()
    private init() {}
    
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    private var lastCode: String?
    
   
    
    private func urlRequestToken(code:String) -> URLRequest {
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
            guard code != lastCode else {
                return
            }
            task?.cancel()
            lastCode = code
            
            let request = urlRequestToken(code: code)
            
            let task = urlSession.objectTask(for: request){(result: Result <OAuthTokenResponseBody, Error>) in
                switch result {
                case .success(let token):
                    completion(.success(token.accesToken))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            self.task = task
            task.resume()
                }
        }
