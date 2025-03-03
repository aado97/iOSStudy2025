//
//  MovieCollectionViewCell.swift
//  weeklyMovieReviewApp
//
//  Created by 도민준 on 3/3/25.
//

import UIKit
import SnapKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        
        posterImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            // 포스터 높이를 셀 가로 길이의 1.5배로 설정 (비율에 맞게 조정)
            make.height.equalTo(contentView.snp.width).multipliedBy(1.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.lessThanOrEqualToSuperview().offset(-8)
        }
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        
        // 포스터 URL이 유효하면 이미지를 비동기 로드, 아니면 placeholder 표시
        if let url = URL(string: movie.posterPath),
           !movie.posterPath.isEmpty,
           movie.posterPath != "포스트 정보 없음" {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.posterImageView.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self.posterImageView.image = UIImage(named: "placeholder")
                    }
                }
            }.resume()
        } else {
            posterImageView.image = UIImage(named: "placeholder")
        }
    }
}
