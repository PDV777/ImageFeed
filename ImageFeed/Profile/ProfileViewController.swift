//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Dmitry on 04.03.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    let avatarImageView = UIImageView()
    let descriptionLabel = UILabel()
    let nameLabel = UILabel()
    let loginName = UILabel()
    let logoutButton = UIButton()
    
    override func viewDidLoad() {
        avatar()
        name()
        login()
        description()
        logout()
        super.viewDidLoad()
    }
    
    func avatar(){
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = UIImage(named: "Avatar")
        view.addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 70),
            avatarImageView.widthAnchor.constraint(equalToConstant: 70),
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 42),
            avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
    }
    func name() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 23)
        nameLabel.text = "Екатерина Новикова"
        nameLabel.textColor = .ypWhite
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor)])
    }
    func login(){
        loginName.translatesAutoresizingMaskIntoConstraints = false
        loginName.font = UIFont.systemFont(ofSize: 13)
        loginName.text = "@ekaterina_nov"
        loginName.textColor = .ypGray
        view.addSubview(loginName)
        NSLayoutConstraint.activate([
            loginName.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            loginName.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor)])
    }
    func description(){
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Hello, World!"
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textColor = .ypWhite
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: loginName.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor)
        ])
    }
    func logout(){
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setBackgroundImage(UIImage(named: "LogoutButton"), for: .normal)
        view.addSubview(logoutButton)
        NSLayoutConstraint.activate([
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            logoutButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)])
    }
}
