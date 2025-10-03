//
//  MainContentVC.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 02.10.2025.
//

import UIKit
import VKID

class MainContentVC: UIViewController {
    
    private let vkId = VKID.shared
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        getPhotos()
    }
    
    private func getPhotos(){
        
        //check for expiration
        let accessToken = vkId.currentAuthorizedSession!.accessToken.value
        
        RequestManager.shared.getAlbumPhotosRequest(with: accessToken){ result in
            switch result{
            case .success(let photoResponse):
                print("RESPONSE --- ---")
                print(photoResponse.response.count)
                break
            case .failure(let _):
                break
            }
        }
    }
    
    private func setup(){
        view.backgroundColor = .systemBackground
        title = "VK Gallery"
        
        let exitButton = UIBarButtonItem(title: "Выход", style: .done, target: self, action: #selector(dismissVC))
        
        navigationItem.rightBarButtonItem = exitButton
    }
    
    private func collectionViewSetup(){
        let layout = UICollectionViewLayout()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        
        view.addSubview(collectionView)
    }
    
    @objc private func dismissVC(){
        vkId.currentAuthorizedSession?.logout(completion: {_ in })
        
        dismiss(animated: true)
    }

}

extension MainContentVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return
    }
}
