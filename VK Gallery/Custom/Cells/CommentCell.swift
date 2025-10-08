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
        selectionStyle = .none
        
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
        authorImage.layer.cornerRadius = 20
        authorImage.clipsToBounds = true
        authorImage.image = UIImage(named: "placeholder-image")
        
        authorImage.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(authorImage)
        
        NSLayoutConstraint.activate(
            [
                authorImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                authorImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
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
        
        contentView.addSubview(authorLabel)
        
        NSLayoutConstraint.activate(
            [
                authorLabel.topAnchor.constraint(equalTo: authorImage.topAnchor),
                authorLabel.leadingAnchor.constraint(equalTo: authorImage.trailingAnchor, constant: 8),
                authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
                authorLabel.heightAnchor.constraint(equalToConstant: 18)
            ]
        )
    }
    
    private func setupCommentLabel(){
        commentLabel.font = .systemFont(ofSize: 14)
        commentLabel.numberOfLines = 0
        commentLabel.lineBreakMode = .byWordWrapping
        
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(commentLabel)
        
        NSLayoutConstraint.activate(
            [
                commentLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
                commentLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
                commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            ]
        )
    }
    
    func setCell(comment: Comment){
        authorLabel.text = comment.authorLabel
        commentLabel.text = comment.authorComment
        
        RequestManager.shared.downloadImage(from: comment.authorImage){ [weak self] result in
            guard let self = self else { return }
            
            switch result{
            case .success(let image):
                authorImage.image = image
                break
            case .failure(_):
                break
            }
        }
    }

}
