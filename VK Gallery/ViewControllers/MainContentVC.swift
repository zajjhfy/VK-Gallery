//
//  MainContentVC.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 02.10.2025.
//

import UIKit
import VKID

#warning("nice tab bar animation?")
class MainContentVC: UIViewController, AlertPresentable {
    
    private var vkId = VKID.shared
    
    private var photos: [PhotoInfo] = []
    private var collectionView: UICollectionView!
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupCollectionView()
        getPhotos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        tabBarController?.tabBar.isHidden = false
    }
    
    private func getPhotos(){
        guard let session = vkId.currentAuthorizedSession else {
            presentAlert(in: self, with: RError.VKError.expiredSession.rawValue)
            
            dismissVC()
            return
        }
        
        // Если на предыдущем экране токен работал, а при переходе истек
        if session.accessToken.isExpired {
            presentAlert(in: self, with: RError.VKError.expiredSession.rawValue)
            
            dismissVC()
            return
        }
        
        let accessToken = session.accessToken.value
        
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
        let layout = UIHelper.getCollectionViewLayout(for: view)
        
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
    
    @objc private func dismissVC(){
        vkId.currentAuthorizedSession?.logout{ _ in
            DispatchQueue.main.async{
                let scene = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                
                scene.changeRootViewController(.authorization)
            }
        }
    }
}

extension MainContentVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoInfo = photos[indexPath.row]
        
        let imageDetailVC = ImageDetailVC(photoInfo: photoInfo)
        
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
