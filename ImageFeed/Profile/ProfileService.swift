import Foundation

//Структура для использования в UI layer
struct Profile {
    let userName:String
    let name:String
    let loginName: String?
    let bio: String?
}

final class ProfileService {
    //Codable структура для декодирования ответа от Unsplash API
    struct ProfileResult: Codable {
        
        let userName: String
        let firstName:String
        let lastName:String?
        let bio: String?
        
        var fullName: String {
            return [firstName, lastName].compactMap{$0}.joined(separator: " ")
        }
    }
    
    static let shared = ProfileService()
    private init() {}
    
    private(set) var profile: Profile?
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    
    
    private func createProfileRequest(token: String) -> URLRequest {
        guard let url = URL(string: "https://api.unsplash.com/me") else {
            fatalError("URL is incorrect!")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    func fetchProfile(token: String, completion: @escaping (Result<ProfileResult,Error>) -> Void) {
        assert(Thread.isMainThread)
        if task != nil {
            task?.cancel() //Отменить предыдущую задачу, если она существует
            
            let request = createProfileRequest(token: token)
            
            let task = urlSession.objectTask(for: request) {(result: Result<ProfileResult,Error>) in
                switch result {
                case .success(let profileResult):
                    let profile = Profile (userName: profileResult.userName,
                                           name: profileResult.fullName,
                                           loginName: "@" + profileResult.userName,
                                           bio: profileResult.bio
                    )
                    self.profile = profile
                    completion(.success(profileResult))
                case .failure(let error):
                    print("error")
                    completion(.failure(error))
                }
            }
            self.task = task
            task.resume()
        }
    }
}
