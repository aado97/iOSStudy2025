//
//  MovieDetailViewController.swift
//  weeklyMovieReviewApp
//
//  Created by 도민준 on 3/3/25.
//

import UIKit
import SnapKit

class MovieDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: MovieDetailViewModel
    
    // 리뷰 목록 테이블뷰
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "ReviewCell")
        return table
    }()
    
    // 즐겨찾기 버튼
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("즐겨찾기", for: .normal)
        return button
    }()
    
    // MARK: - Init
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.movie.title
        view.backgroundColor = .white
        
        setupUI()
        bindViewModel()
        
        // 리뷰 목록 불러오기
        viewModel.loadReviews()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.addSubview(favoriteButton)
        view.addSubview(tableView)
        
        // 즐겨찾기 버튼 설정
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        favoriteButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        // 리뷰 목록 테이블뷰 설정
        tableView.snp.makeConstraints { make in
            make.top.equalTo(favoriteButton.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        
        // 내비게이션 바 오른쪽 버튼 (리뷰 작성)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "리뷰 작성",
            style: .plain,
            target: self,
            action: #selector(addReview)
        )
        
        updateFavoriteButton()
    }
    
    // MARK: - ViewModel Binding
    
    private func bindViewModel() {
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func addReview() {
        let alert = UIAlertController(
            title: "리뷰 작성",
            message: "영화에 대한 리뷰를 작성해주세요",
            preferredStyle: .alert
        )
        alert.addTextField { textField in
            textField.placeholder = "리뷰 내용"
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "저장", style: .default, handler: { [weak self] _ in
            guard let self = self,
                  let text = alert.textFields?.first?.text,
                  !text.isEmpty else { return }
            self.viewModel.addReview(content: text)
        }))
        present(alert, animated: true)
    }
    
    @objc private func toggleFavorite() {
        let movie = viewModel.movie
        if viewModel.isFavorite {
            FavoritesManager.shared.removeFavorite(movie)
        } else {
            FavoritesManager.shared.addFavorite(movie)
        }
        updateFavoriteButton()
    }
    
    private func updateFavoriteButton() {
        let title = viewModel.isFavorite ? "즐겨찾기 해제" : "즐겨찾기"
        favoriteButton.setTitle(title, for: .normal)
    }
}

// MARK: - UITableView Delegate & DataSource

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath)
        let review = viewModel.reviews[indexPath.row]
        cell.textLabel?.text = review.content
        return cell
    }
}
