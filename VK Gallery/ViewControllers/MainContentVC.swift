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
        setupCollectionView()
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
    
    private func setupCollectionView(){
        let layout = getCollectionViewLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseId)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
    
    private func getCollectionViewLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        
        let width: Double = (view.frame.width / 2) - 6
        
        layout.itemSize = CGSize(width: width, height: width)
        
        return layout
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

extension MainContentVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseId, for: indexPath) as! PhotoCell
        
        photoCell.setImageView(with: "cat")
        return photoCell
    }
}
