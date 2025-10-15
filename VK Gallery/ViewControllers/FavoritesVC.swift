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
    
    private var currentMenuState: FilterMenu.MenuState?
    private var currentSortOption: FilterMenu.SortBy?
    
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
        
        updatePhotos()
    }
    
    private func updatePhotos() {
        guard let currentMenuState = currentMenuState, let currentSortOption = currentSortOption else { return }
        
        photos = PersistentManager.shared.getPhotos(by: currentMenuState, sort: currentSortOption)
        collectionView.reloadData()
    }
}

extension FavoritesVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = ImageDetailVC(photo: photos[indexPath.row])
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
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
    func didInitDefaultStates(menuState: FilterMenu.MenuState, sortOption: FilterMenu.SortBy) {
        currentMenuState = menuState
        currentSortOption = sortOption
        
        photos = PersistentManager.shared.getPhotos(by: menuState, sort: sortOption)
        collectionView.reloadData()
    }
    
    func didUpdateMenu(menu: UIMenu) {
        if navigationItem.rightBarButtonItem?.menu != nil {
            navigationItem.rightBarButtonItem?.menu = menu
            return
        }
        
        let button = UIBarButtonItem(image: UIImage(systemName: SFSymbols.FilterMenuSymbols.filter), primaryAction: nil, menu: menu)
        
        navigationItem.rightBarButtonItem = button
    }
    
    func didChangeState(with state: FilterMenu.MenuState, sortOption: FilterMenu.SortBy) {
        currentMenuState = state
        currentSortOption = sortOption
        
        photos = PersistentManager.shared.getPhotos(by: state, sort: sortOption)
        collectionView.reloadData()
    }
}

