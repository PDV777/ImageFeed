//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Dmitry on 04.03.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let avatarImageView = UIImageView()
    private let descriptionLabel = UILabel()
    private let nameLabel = UILabel()
    private let loginName = UILabel()
    private let logoutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transAdd()
        avatar()
        name()
        login()
        description()
        logout()
    }
    
    private func transAdd(){
        [avatarImageView,
         descriptionLabel,
         nameLabel,
         loginName,
         logoutButton].forEach{$0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)}
    }
    private func avatar(){
        avatarImageView.image = UIImage(named: "Avatar")
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 70),
            avatarImageView.widthAnchor.constraint(equalToConstant: 70),
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 42),
            avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
    }
    private func name() {
        nameLabel.font = UIFont.boldSystemFont(ofSize: 23)
        nameLabel.text = "Екатерина Новикова"
        nameLabel.textColor = .ypWhite
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor)])
    }
    private func login(){
        loginName.font = UIFont.systemFont(ofSize: 13)
        loginName.text = "@ekaterina_nov"
        loginName.textColor = .ypGray
        NSLayoutConstraint.activate([
            loginName.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            loginName.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor)])
    }
    private func description(){
        descriptionLabel.text = "Hello, World!"
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textColor = .ypWhite
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: loginName.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor)
        ])
    }
    private func logout(){
        logoutButton.setBackgroundImage(UIImage(named: "LogoutButton"), for: .normal)
        NSLayoutConstraint.activate([
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            logoutButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)])
    }
}
