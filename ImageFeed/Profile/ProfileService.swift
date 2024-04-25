import Foundation

//Структура для использования в UI layer
struct Profile {
    let userName:String
    let firstName:String
    let loginName: String
    let lastName: String?
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
    func fetchProfile(token: String, completion: @escaping (Result<Profile,Error>) -> Void) {
        let _: (Result<Profile, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        task?.cancel() //Отменить предыдущую задачу, если она существует
        let request = createProfileRequest(token: token)
        task = urlSession.dataTask(with: request) { data, responce, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data was nil."])))
                return
            }
            do {
                let profileResult = try JSONDecoder().decode(ProfileResult.self, from: data)
                let profile = Profile (userName: profileResult.userName,
                                       firstName: profileResult.firstName,
                                       loginName: "@" + profileResult.userName,
                                       lastName: profileResult.lastName,
                                       bio: profileResult.bio
                )
                completion(.success(profile))
            } catch{
                completion(.failure(error))
            }
        }
        task?.resume()
    }
}
