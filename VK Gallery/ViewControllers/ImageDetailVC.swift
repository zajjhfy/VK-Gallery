//
//  ImageDetailVC.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 03.10.2025.
//

import UIKit

class ImageDetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup(){
        view.backgroundColor = .systemBackground
        title = "Image Details"
        
        let exitButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(shareImage))
        
        navigationItem.rightBarButtonItem = exitButton
    }
    
    @objc private func shareImage(){
        print("share")
        
    }

}
