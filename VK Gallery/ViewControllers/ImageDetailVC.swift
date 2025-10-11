//
//  ImageDetailVC.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 03.10.2025.
//

import UIKit

class ImageDetailVC: UIViewController, AlertPresentable {

    private var photoInfo: PhotoInfo!
    private let imageView = UIImageView()
    private let likeButton = UIButton()
    private let commentsButton = UIButton()
    
    private var favoritesBarButtonItem = UIBarButtonItem()
    
    private var imageIsNil = true
    
    private var halfScreenWidth: CGFloat {
        return view.bounds.width / 2
    }
    
    init(photoInfo: PhotoInfo){
        super.init(nibName: nil, bundle: nil)
        
        self.photoInfo = photoInfo
    }
    
    init(photo: Photo){
        super.init(nibName: nil, bundle: nil)
        
        photoInfo = PhotoInfo(imageId: Int(photo.id), imageUrl: photo.url!, postedAtDate: photo.postedAt!, commentsCount: Int(photo.commentsCount), likesCount: Int(photo.likesCount))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageView()
        setupLikeButton()
        setupCommentsButton()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setup(){
        view.backgroundColor = .systemBackground
        title = photoInfo.postedAtDate
        
        setupBarButtons()
    }
    
    private func setupBarButtons() {
        let photo = PersistentManager.shared.getPhoto(photoInfo.imageId)
        
        let shareBarButtonItem = UIBarButtonItem(image: UIImage(systemName: SFSymbols.share), style: .plain, target: self, action: #selector(shareImage))
        
        favoritesBarButtonItem = UIBarButtonItem(image: UIImage(systemName: photo != nil ? SFSymbols.favoritesFill : SFSymbols.favorites), style: .plain, target: self, action: #selector(addToFavorites))
        
        navigationItem.rightBarButtonItems = [shareBarButtonItem, favoritesBarButtonItem]
    }
    
    private func setupLikeButton(){
        likeButton.backgroundColor = .systemBackground
        likeButton.setImage(UIImage(systemName: SFSymbols.like), for: .normal)
        likeButton.setTitle("\(photoInfo.likesCount)", for: .normal)
        
        likeButton.tintColor = .label
        likeButton.setTitleColor(.label, for: .normal)
        
        view.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                likeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                likeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                likeButton.widthAnchor.constraint(equalToConstant: halfScreenWidth),
                likeButton.heightAnchor.constraint(equalToConstant: 100)
            ]
        )
    }
    
    private func setupCommentsButton(){
        commentsButton.backgroundColor = .systemBackground
        commentsButton.setImage(UIImage(systemName: SFSymbols.comment), for: .normal)
        commentsButton.setTitle("\(photoInfo.commentsCount)", for: .normal)
        
        commentsButton.tintColor = .label
        commentsButton.setTitleColor(.label, for: .normal)
        
        commentsButton.addTarget(self, action: #selector(openComments), for: .touchUpInside)
        
        view.addSubview(commentsButton)
        commentsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                commentsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                commentsButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor),
                commentsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                commentsButton.heightAnchor.constraint(equalToConstant: 100)
            ]
        )
    }
    
    private func setupImageView(){
        imageView.image = UIImage(named: "placeholder-image")
        
        RequestManager.shared.downloadImage(from: photoInfo.imageUrl){ [weak self] result in
            guard let self = self else { return }
            
            switch result{
            case .success(let image):
                self.imageView.image = image
                self.imageIsNil = false
            case .failure(let error):
                self.presentAlert(in: self, with: error.rawValue)
            }
        }
        
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 260)
            ]
        )
    }
    
    @objc private func openComments(){
        let navVC = UINavigationController(rootViewController: CommentsVC(photoInfo: photoInfo))
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true)
    }
    
    @objc private func shareImage(){
        guard !imageIsNil else {
            presentAlert(in: self, with: RError.ShareError.shareImageGeneralError.rawValue)
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        
        present(activityViewController, animated: true)
    }
    
    @objc private func addToFavorites(){
        let didCreate = PersistentManager.shared.createPhoto(photoInfo: photoInfo)
        
        // disappears
        if didCreate {
            favoritesBarButtonItem.image = UIImage(systemName: SFSymbols.favoritesFill)
        } else {
            _ = PersistentManager.shared.deletePhoto(Int32(photoInfo.imageId))
            favoritesBarButtonItem.image = UIImage(systemName: SFSymbols.favorites)
        }
        
    }

}
