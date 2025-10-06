//
//  ImageDetailVC.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 03.10.2025.
//

import UIKit

class ImageDetailVC: UIViewController {

    private var dateStr = ""
    private var imageView = UIImageView()
    
    init(dateStr: String, image: UIImage){
        super.init(nibName: nil, bundle: nil)
        
        self.dateStr = dateStr
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageView()
        setup()
    }
    
    private func setup(){
        view.backgroundColor = .systemBackground
        title = dateStr
        
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareImage))
        
        navigationItem.rightBarButtonItem = shareButton
    }
    
    private func setupImageView(){
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 250)
            ]
        )
    }
    
    @objc private func shareImage(){
        guard let image = imageView.image else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        present(activityViewController, animated: true)
    }

}
