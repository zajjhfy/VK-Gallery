//
//  MainContentVC.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 02.10.2025.
//

import UIKit
import VKID

class MainContentVC: UIViewController, AlertPresentable {
    
    private let vkId = VKID.shared
    
    private var photos: [PhotoInfo] = []
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        getPhotos()
        setupCollectionView()
    }
    
    private func getPhotos(){
        // Если на предыдущем экране токен работал, а при переходе истек
        if vkId.currentAuthorizedSession!.accessToken.isExpired {
            presentAlert(in: self, with: "Сессия истекла. Войдите в аккаунт чтобы продолжить!")
            
            dismissVC()
            return
        }
        
        let accessToken = vkId.currentAuthorizedSession!.accessToken.value
        
        RequestManager.shared.getAlbumPhotosRequest(with: accessToken){ [weak self] result in
            guard let self = self else { return }
            
            switch result{
            case .success(let photos):
                DispatchQueue.main.async{
                    self.photos = photos
                    self.collectionView.reloadData()
                }
                break
            case .failure(let error):
                presentAlert(in: self, with: error.rawValue)
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
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 3
        
        let width: Double = (view.frame.width / 2) - 3
        
        layout.itemSize = CGSize(width: width, height: width/1.5)
        
        return layout
    }
    
    @objc private func dismissVC(){
        vkId.currentAuthorizedSession?.logout(completion: {_ in })
        
        dismiss(animated: true)
    }

}

extension MainContentVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageDetailVC = ImageDetailVC(photoInfo: photos[indexPath.row])
        
        navigationController?.pushViewController(imageDetailVC, animated: true)
    }
}

extension MainContentVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseId, for: indexPath) as! PhotoCell
        
        photoCell.setCell(with: photos[indexPath.row].imageUrl)
        return photoCell
    }
}
