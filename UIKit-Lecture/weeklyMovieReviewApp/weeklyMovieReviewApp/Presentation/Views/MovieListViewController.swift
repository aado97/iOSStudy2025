//
//  MovieListViewController.swift
//  weeklyMovieReviewApp
//
//  Created by 도민준 on 3/3/25.
//

import UIKit
import SnapKit

class MovieListViewController: UIViewController {
    
    // MARK: - UI Components
    
    /// 인기 영화 컬렉션뷰 (상단, 가로 스크롤)
    private let popularCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        cv.backgroundColor = .white
        return cv
    }()
    
    /// 즐겨찾기 컬렉션뷰 (하단, 가로 스크롤)
    private let favoriteCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        cv.backgroundColor = .white
        return cv
    }()
    
    // 섹션 헤더 (인기 영화 / 즐겨찾기) 표시용
    private let popularHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "인기 영화"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let favoriteHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "즐겨찾기"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    // MARK: - Data Sources
    
    private var popularMovies: [Movie] = []
    private var favoriteMovies: [Movie] = []
    
    // MVVM ViewModel
    private var viewModel: MovieListViewModel!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "영화"
        view.backgroundColor = .white
        
        view.addSubview(popularHeaderLabel)
        view.addSubview(popularCollectionView)
        view.addSubview(favoriteHeaderLabel)
        view.addSubview(favoriteCollectionView)
        
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        
        setupConstraints()
        configureViewModel()
        
        favoriteMovies = FavoritesManager.shared.getFavorites()
    }
    
    // 화면이 다시 나타날 때마다 최신 즐겨찾기 목록 업데이트
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteMovies = FavoritesManager.shared.getFavorites()
        favoriteCollectionView.reloadData()
    }
    
    // MARK: - Setup Methods
    
    private func setupConstraints() {
        popularHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(30)
        }
        
        popularCollectionView.snp.makeConstraints { make in
            make.top.equalTo(popularHeaderLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(270)
        }
        
        favoriteHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(popularCollectionView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(30)
        }
        
        favoriteCollectionView.snp.makeConstraints { make in
            make.top.equalTo(favoriteHeaderLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(270)
        }
    }
    
    private func configureViewModel() {
        let movieUseCase = MovieUseCase(repository: MovieRepositoryImpl())
        viewModel = MovieListViewModel(movieUseCase: movieUseCase)
        viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.popularMovies = self?.viewModel.movies ?? []
                self?.popularCollectionView.reloadData()
            }
        }
        viewModel.fetchMovies()
    }
}

// MARK: - UICollectionView DataSource & Delegate

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == popularCollectionView {
            return popularMovies.count
        } else {
            return favoriteMovies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.identifier,
            for: indexPath
        ) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        if collectionView == popularCollectionView {
            let movie = popularMovies[indexPath.item]
            cell.configure(with: movie)
        } else {
            let movie = favoriteMovies[indexPath.item]
            cell.configure(with: movie)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height * 0.8
        let width = height * 0.66  // 포스터 비율 (2:3)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let movie: Movie
        
        if collectionView == popularCollectionView {
            movie = popularMovies[indexPath.item]
        } else {
            movie = favoriteMovies[indexPath.item]
            print("Selected favorite movie: \(movie.title)")
        }
        
        let reviewUseCase = ReviewUseCase(repository: ReviewRepositoryImpl())
        let detailVM = MovieDetailViewModel(movie: movie, reviewUseCase: reviewUseCase)
        let detailVC = MovieDetailViewController(viewModel: detailVM)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
