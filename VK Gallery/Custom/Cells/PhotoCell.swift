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
    
    func setImageView(with imageString: String){
        imageView.image = UIImage(named: imageString)
    }
}
