//
//  PostTableViewCell.swift
//  weeklyMyContentManager
//
//  Created by 도민준 on 3/10/25.
//

import UIKit
import SnapKit

class PostTableViewCell: UITableViewCell {
    
    static let identifier = "PostTableViewCell"
    
    private let postImageView = UIImageView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let previewLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        postImageView.contentMode = .scaleAspectFit
        
        titleLabel.font = .boldSystemFont(ofSize: 16)
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .gray
        
        previewLabel.font = .systemFont(ofSize: 14)
        previewLabel.textColor = .darkGray
        
        contentView.addSubview(postImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(previewLabel)
    }
    
    private func setupLayout() {
        postImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(postImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        previewLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func configure(with post: Post) {
        postImageView.image = post.image
        titleLabel.text = post.title
        
        // 날짜 포맷
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: post.date)
        
        dateLabel.text = dateString
        previewLabel.text = post.preview
    }
}

