//
//  FavoritesVC.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 11.10.2025.
//

import UIKit

#warning("if no data display something")
class FavoritesVC: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.getCollectionViewLayout(for: view))
        
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseId)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private var filterMenu: FilterMenu!
    
    private var photos: [Photo] = []
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder?) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        
        filterMenu = FilterMenu(title: "Favorites", delegate: self)
        
        view.addSubview(collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        tabBarController?.tabBar.isHidden = false
        
        getPhotos()
    }
    
    private func getPhotos() {
        photos = PersistentManager.shared.getPhotos()
        collectionView.reloadData()
    }
    
}

extension FavoritesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = ImageDetailVC(photo: photos[indexPath.row])
        
        navigationController?.pushViewController(destVC, animated: true)
    }
}

extension FavoritesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseId, for: indexPath) as! PhotoCell
        
        cell.setCell(with: photos[indexPath.row].url!)
        
        return cell
    }
}

extension FavoritesVC: FilterMenuDelegate {
    func didChangeSortOption(with option: FilterMenu.SortBy) {
        print(option.rawValue)
    }
    
    func didUpdateMenu(menu: UIMenu) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: nil, menu: menu)
    }
    
    func didChangeMenuState(with state: FilterMenu.MenuState) {
        print(state.rawValue)
    }
}

