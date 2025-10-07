//
//  ImageDetailVC.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 03.10.2025.
//

import UIKit

class ImageDetailVC: UIViewController {

    private var photoInfo: PhotoInfo!
    private var imageView = UIImageView()
    private var likeButton = UIButton()
    private var commentsButton = UIButton()
    
    private var halfScreenWidth: CGFloat {
        return view.bounds.width / 2
    }
    
    init(photoInfo: PhotoInfo, image: UIImage){
        super.init(nibName: nil, bundle: nil)
        
        self.photoInfo = photoInfo
        imageView.image = image
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
    
    private func setup(){
        view.backgroundColor = .systemBackground
        title = photoInfo.postedAtDate
        
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareImage))
        
        navigationItem.rightBarButtonItem = shareButton
    }
    
    private func setupLikeButton(){
        likeButton.backgroundColor = .darkGray
        likeButton.setImage(UIImage(systemName: SFSymbols.like), for: .normal)
        likeButton.setTitle("\(photoInfo.likesCount)", for: .normal)
        likeButton.tintColor = .white
        
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
        commentsButton.backgroundColor = .darkGray
        commentsButton.setImage(UIImage(systemName: SFSymbols.comment), for: .normal)
        commentsButton.setTitle("\(photoInfo.commentsCount)", for: .normal)
        commentsButton.tintColor = .white
        
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
        
        present(navVC, animated: true)
    }
    
    @objc private func shareImage(){
        guard let image = imageView.image else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        present(activityViewController, animated: true)
    }

}
