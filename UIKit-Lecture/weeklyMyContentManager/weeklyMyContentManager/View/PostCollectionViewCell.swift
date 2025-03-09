//
//  PostCollectionViewCell.swift
//  weeklyMyContentManager
//
//  Created by 도민준 on 3/10/25.
//

import UIKit
import SnapKit

class PostCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PostCollectionViewCell"
    
    private let postImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        
        contentView.addSubview(postImageView)
    }
    
    private func setupLayout() {
        postImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with post: Post) {
        postImageView.image = post.image
    }
}

