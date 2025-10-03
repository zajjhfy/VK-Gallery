//
//  PhotoCell.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 03.10.2025.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    static let reuseId = "PhotoCell"
    
    private var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        imageView = UIImageView()
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
    
    func setCell(with imageString: String){
        imageView.downloadImage(from: imageString)
    }
}
