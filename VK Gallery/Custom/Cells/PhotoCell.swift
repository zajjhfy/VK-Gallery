//
//  PhotoCell.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 03.10.2025.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    static let reuseId = "PhotoCell"
    
    private var imageView = UIImageView()
    private var isImageDownloaded = false
    private var currentImageUrlString = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        imageView.image = UIImage(named: "placeholder-image")
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = UIImage(named: "placeholder-image")
        isImageDownloaded = false
        currentImageUrlString = ""
    }
    
    func setCell(with imageString: String){
        currentImageUrlString = imageString
        
        RequestManager.shared.downloadImage(from: imageString){ [weak self] result in
            guard let self = self else { return }
            
            switch result{
            case .success(let image):
                if self.currentImageUrlString == imageString {
                    self.imageView.image = image
                    self.isImageDownloaded = true
                }
            case .failure(_):
                break
            }
        }
    }
}
