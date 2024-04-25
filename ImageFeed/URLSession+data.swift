import UIKit

enum NetworkError: Error {
    
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case decodingError(Error)
}

extension URLSession {
    
    func data(
        for request: URLRequest,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> URLSessionTask {
        let fulfillCompletionOnTheMainThread: (Result<Data, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        let task = dataTask(with: request, completionHandler: { data, response, error in
            if let data = data, let response = response, let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if 200 ..< 300 ~= statusCode {
                    fulfillCompletionOnTheMainThread(.success(data))
                } else {
                    fulfillCompletionOnTheMainThread(.failure(NetworkError.httpStatusCode(statusCode)))
                }
            } else if let error = error {
                fulfillCompletionOnTheMainThread(.failure(NetworkError.urlRequestError(error)))
            } else {
                fulfillCompletionOnTheMainThread(.failure(NetworkError.urlSessionError))
            }
        })
        return task
    }
    
        func objectTask<T: Decodable>(
            for request:URLRequest,
            decoder: JSONDecoder = JSONDecoder(),
            completion: @escaping (Result<T, Error>) -> Void
        ) -> URLSessionTask {
            let task = data(for: request) { result in
                switch result {
                case .success(let data):
                    do {
                        let decodedObject = try decoder.decode(T.self, from:data)
                        completion(.success(decodedObject))
                    } catch {
                        completion(.failure(NetworkError.decodingError(error)))
                    }
                case.failure(let error):
                    completion(.failure(error))
                }
            }
            return task
        }
}
