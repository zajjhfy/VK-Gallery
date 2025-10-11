//
//  UIHelper.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 11.10.2025.
//

import UIKit

enum UIHelper {
    static func getCollectionViewLayout(for view: UIView) -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 3
        
        let width: Double = (view.frame.width / 2) - 3
        
        layout.itemSize = CGSize(width: width, height: width/1.5)
        
        return layout
    }
}
