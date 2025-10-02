//
//  MainContentVC.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 02.10.2025.
//

import UIKit

class MainContentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup(){
        view.backgroundColor = .systemBackground
        title = "VK Gallery"
        
        let exitButton = UIBarButtonItem(title: "Выход", style: .done, target: self, action: #selector(dismissVC))
        
        navigationItem.rightBarButtonItem = exitButton
    }
    
    @objc private func dismissVC(){
        dismiss(animated: true)
    }

}
