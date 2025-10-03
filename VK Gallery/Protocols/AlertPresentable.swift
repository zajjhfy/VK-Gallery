//
//  AlertPresentable.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 03.10.2025.
//

import UIKit

protocol AlertPresentable: AnyObject { }

extension AlertPresentable {
    func presentAlert(in viewController: UIViewController, with message: String) {
        DispatchQueue.main.async{
            let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
            alertController.addAction(.init(title: "OK", style: .default))
            
            viewController.present(alertController, animated: true)
        }
    }
}
