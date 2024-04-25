import UIKit

final class SplashViewController: UIViewController{
    
    private let showAuthSegueId = "ShowAuth"
    private let storage = OAuth2TokenStorage()
    private let oauth2Service = OAuth2Service.shared
    private let profileService = ProfileService.shared
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        segueSettings()
    }
    
    private func segueSettings() {
        if storage.token != nil {
            switchToTabBarController()
        } else {
            performSegue(withIdentifier: showAuthSegueId, sender: nil)
        }
    }
    private func fetchProfile(_ token: String) {
        profileService.fetchProfile(token: token) { [weak self] result in
            switch result {
            case .success(let profileResult):
                print("Profile fetched successfully")
                self?.switchToTabBarController()
            case .failure(let error):
                print("Error fetching profile: \(error.localizedDescription)")
                self?.performSegue(withIdentifier: self?.showAuthSegueId ?? "", sender: nil)
            }
        }
    }
}

extension SplashViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showAuthSegueId {
            guard
                let navigationController = segue.destination as? UINavigationController,
                let viewController = navigationController.viewControllers[0] as? AuthViewController
            else {
                assertionFailure("Failed to prepare for \(showAuthSegueId)")
                return
            }
            viewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}
extension SplashViewController:AuthViewControllerDelegate {
    
    func didAuthenticate(_ vc: AuthViewController) {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
//            guard let token = storage.token else { return }
            self.switchToTabBarController()
        }
    }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid window configuration")
            return
        }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "TabBarViewController")
        window.rootViewController = tabBarController
    }
}


