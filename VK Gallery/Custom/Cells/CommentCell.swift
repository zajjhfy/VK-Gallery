//
//  CommentCell.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 07.10.2025.
//

import UIKit

class CommentCell: UITableViewCell {
    
    static let reuseId = "CommentCell"
    
    private var authorImage = UIImageView()
    private var authorLabel = UILabel()
    private var commentLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        setupAuthorImage()
        setupAuthorLabel()
        setupCommentLabel()
    }
    
    private func setupAuthorImage(){
        authorImage.layer.cornerRadius = 10
        authorImage.clipsToBounds = true
        authorImage.image = UIImage(named: "placeholder-image")
        
        authorImage.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(authorImage)
        
        NSLayoutConstraint.activate(
            [
                authorImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                authorImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                authorImage.heightAnchor.constraint(equalToConstant: 50),
                authorImage.widthAnchor.constraint(equalToConstant: 50)
            ]
        )
    }
    
    private func setupAuthorLabel(){
        authorLabel.text = "Author"
        
        authorLabel.font = .systemFont(ofSize: 14, weight: .bold)
        authorLabel.numberOfLines = 1
        authorLabel.adjustsFontSizeToFitWidth = false
        authorLabel.lineBreakMode = .byTruncatingTail
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(authorLabel)
        
        NSLayoutConstraint.activate(
            [
                authorLabel.topAnchor.constraint(equalTo: authorImage.topAnchor),
                authorLabel.leadingAnchor.constraint(equalTo: authorImage.trailingAnchor, constant: 8),
                authorLabel.heightAnchor.constraint(equalToConstant: 18)
            ]
        )
    }
    
    private func setupCommentLabel(){
        commentLabel.text = "я позадавал кучу вопросов чату гпт, попробовал проверять респонс на уникальные данные, короче, ошибка поидее в том, что асинхронность тупая блин из за того задачи могу завершаться в непредсказуемое время. При переиспользовании ячейки, задача 1 может завершиться позже чем задача 2, из за этого ставится в ячейку уже существующее в коллекции фото"
        commentLabel.font = .systemFont(ofSize: 14)
        commentLabel.numberOfLines = 0
        commentLabel.lineBreakMode = .byClipping
        
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(commentLabel)
        
        NSLayoutConstraint.activate(
            [
                commentLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
                commentLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
                commentLabel.heightAnchor.constraint(equalToConstant: 18)
            ]
        )
    }
    

}
