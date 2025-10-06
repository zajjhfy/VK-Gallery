//
//  AuthorizationVC.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 02.10.2025.
//

import UIKit
import VKID

class AuthorizationVC: UIViewController, AlertPresentable {
    
    private let vkId = VKID.shared
    
    private let appTitle = UILabel()
    private let authButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkAuthorization()
    }
    
    private func setup(){
        view.backgroundColor = .systemBackground
        
        setupVKConfiguration()
        setupAuthButton()
        setupAppTitle()
    }
    
    private func checkAuthorization(){
        guard let session = vkId.currentAuthorizedSession else {
            return
        }
        
        if !session.accessToken.isExpired { presentContentVC() }
        else {
            session.getFreshAccessToken { [weak self] result in
                guard let self = self else { return }
                
                switch result{
                case .success:
                    self.presentContentVC()
                case .failure:
                    self.presentAlert(in: self, with: "Время сессии истекло, пожалуйста авторизуйтесь вновь")
                }
            }
        }
    }
    
    private func setupVKConfiguration(){
        let credentials = AppCredentials(clientId: "54203133", clientSecret: "GliCO7rXMBdJiCvvLhFx")
        
        do{
            try vkId.set(config: Configuration(appCredentials: credentials))
        }
        catch{
            presentAlert(in: self, with: error.localizedDescription)
        }
    }
    
    private func setupAuthButton(){
        authButton.translatesAutoresizingMaskIntoConstraints = false
        authButton.addTarget(self, action: #selector(onAuthTap), for: .touchUpInside)
        
        authButton.setTitle("Авторизоваться", for: .normal)
        authButton.setTitleColor(.white, for: .normal)
        authButton.backgroundColor = .blue
        
        view.addSubview(authButton)
        
        NSLayoutConstraint.activate(
            [
                authButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90),
                authButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                authButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
                authButton.heightAnchor.constraint(equalToConstant: 50)
            ]
        )
    }
    
    private func setupAppTitle(){
        appTitle.translatesAutoresizingMaskIntoConstraints = false
        
        appTitle.text = "VK Gallery"
        appTitle.textColor = .label
        appTitle.font = .systemFont(ofSize: 45, weight: .bold)
        
        view.addSubview(appTitle)
        
        NSLayoutConstraint.activate(
            [
                appTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
                appTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                appTitle.heightAnchor.constraint(equalToConstant: 50)
            ]
        )
    }
    
    private func presentContentVC(){
        DispatchQueue.main.async{ [weak self] in
            guard let self = self else { return }
            
            let navController = UINavigationController(rootViewController: MainContentVC(vkId: self.vkId))
            navController.modalPresentationStyle = .fullScreen
            navController.title = "VK Gallery"
            
            self.present(navController, animated: true)
        }
    }
    
    @objc private func onAuthTap(){
        vkId.authorize(using: .newUIWindow){ [weak self] result in
            guard let self = self else { return }
            
            switch result{
            case .success(_):
                presentContentVC()
            case .failure(let error):
                presentAlert(in: self, with: error.localizedDescription)
            }
        }
    }

}
