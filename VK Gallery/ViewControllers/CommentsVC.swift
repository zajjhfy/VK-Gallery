//
//  CommentsVC.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 07.10.2025.
//

import UIKit
import VKID

class CommentsVC: UIViewController {
    
    private var photoInfo: PhotoInfo!
    private var tableView: UITableView!
    
    init(photoInfo: PhotoInfo){
        super.init(nibName: nil, bundle: nil)
        
        self.photoInfo = photoInfo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupTableView()
        getComments()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getComments(){
        let vkId = VKID.shared
        let token = vkId.currentAuthorizedSession?.accessToken.value ?? ""
        
        RequestManager.shared.getCommentsByPhotoId(in: photoInfo.imageId, with: token)
    }
    
    private func setup(){
        view.backgroundColor = .systemBackground
        title = "Комментарии"
        
        let returnButton = UIBarButtonItem(title: "Назад", style: .done, target: self, action: #selector(dismissVC))
        
        navigationItem.leftBarButtonItem = returnButton
    }
    
    private func setupTableView(){
        tableView = UITableView(frame: view.bounds)
        
        tableView.rowHeight = 80
        tableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.reuseId)
        
        view.addSubview(tableView)
        
        tableView.dataSource = self
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }

}

extension CommentsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.reuseId) as! CommentCell
        
        return cell
    }
}
