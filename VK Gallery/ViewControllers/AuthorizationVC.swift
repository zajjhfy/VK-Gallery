//
//  AuthorizationVC.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 02.10.2025.
//

import UIKit
import VKID

class AuthorizationVC: UIViewController {
    
    private let vkId = VKID.shared
    
    private let appTitle = UILabel()
    private let authButton = UIButton()
    private let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup(){
        view.backgroundColor = .systemBackground
        
        setupAlertController()
        setupVKConfiguration()
        setupAuthButton()
        setupAppTitle()
        
        if vkId.currentAuthorizedSession != nil {
            presentContentVC()
        }
    }
    
    private func setupVKConfiguration(){
        let credentials = AppCredentials(clientId: "54203133", clientSecret: "GliCO7rXMBdJiCvvLhFx")
        
        do{
            try vkId.set(config: Configuration(appCredentials: credentials))
        }
        catch{
            presentAlert(with: error.localizedDescription)
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
        appTitle.textColor = .black
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
    
    private func setupAlertController(){
        alertController.title = "Ошибка"
        alertController.message = "Все плохо.."
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
    }
    
    private func presentContentVC(){
        DispatchQueue.main.async{ [weak self] in
            guard let self = self else { return }
            
            let navController = UINavigationController(rootViewController: MainContentVC())
            navController.modalPresentationStyle = .fullScreen
            navController.title = "VK Gallery"
            
            self.present(navController, animated: true)
        }
    }
    
    private func presentAlert(with message: String){
        DispatchQueue.main.async{ [weak self] in
            guard let self = self else { return }
            
            self.alertController.message = message
            
            self.present(alertController, animated: true)
        }
    }
    
    @objc private func onAuthTap(){
        vkId.authorize(using: .newUIWindow){ [weak self] result in
            guard let self = self else { return }
            
            switch result{
            case .success(let _):
                presentContentVC()
            case .failure(let error):
                presentAlert(with: error.localizedDescription)
            }
        }
    }

}
