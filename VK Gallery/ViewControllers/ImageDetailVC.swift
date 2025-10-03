//
//  ImageDetailVC.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 03.10.2025.
//

import UIKit

class ImageDetailVC: UIViewController {

    private var photo: PhotoInfo!
    private var imageView: UIImageView!
    
    init(photoInfo: PhotoInfo){
        super.init(nibName: nil, bundle: nil)
        
        photo = photoInfo
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
        title = photo.postedAtDate
        
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareImage))
        
        navigationItem.rightBarButtonItem = shareButton
    }
    
    private func setupImageView(){
        imageView = UIImageView()
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 300)
            ]
        )
        
        imageView.downloadImage(from: photo.imageUrl)
    }
    
    @objc private func shareImage(){
        let imageToShare = imageView.image
        
        let activityViewController = UIActivityViewController(activityItems: [imageToShare!], applicationActivities: nil)
        
        present(activityViewController, animated: true)
    }

}
