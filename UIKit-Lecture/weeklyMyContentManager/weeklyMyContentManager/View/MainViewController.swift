//
//  ViewController.swift
//  weeklyMyContentManager
//
//  Created by 도민준 on 3/10/25.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let modeSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = false // false면 table, true면 collection
        return sw
    }()
    
    private let modeLabel: UILabel = {
        let label = UILabel()
        label.text = "컬렉션뷰로 보기" // 기본값(테이블 모드)
        label.textColor = .black
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false // 초기에는 tableView가 보임
        return tableView
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isHidden = true // 초기에는 collectionView는 숨김
        cv.backgroundColor = .white
        return cv
    }()
    
    // MARK: - ViewModel
    
    private let viewModel = MainViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        setupTableView()
        setupCollectionView()
        bindViewModel()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Home" // 네비게이션 타이틀
        
        // 네비게이션 바 우측에 + 버튼(추가버튼)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAddButton)
        )
        
        // 토글 스위치 액션 연결
        modeSwitch.addTarget(self, action: #selector(didChangeModeSwitch(_:)), for: .valueChanged)
        
        // 서브뷰 추가
        view.addSubview(modeSwitch)
        view.addSubview(modeLabel)
        view.addSubview(tableView)
        view.addSubview(collectionView)
    }
    
    private func setupLayout() {
        modeSwitch.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
        }
        
        modeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(modeSwitch.snp.centerY)
            make.leading.equalTo(modeSwitch.snp.trailing).offset(8)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(modeSwitch.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(modeSwitch.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
    }
    
    private func bindViewModel() {
        // displayMode가 바뀔 때마다 UI 업데이트
        viewModel.onDisplayModeChanged = { [weak self] mode in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch mode {
                case .table:
                    self.modeLabel.text = "컬렉션뷰로 보기"
                    self.tableView.isHidden = false
                    self.collectionView.isHidden = true
                case .collection:
                    self.modeLabel.text = "텍스트뷰로 보기"
                    self.tableView.isHidden = true
                    self.collectionView.isHidden = false
                }
            }
        }
        
        // posts가 업데이트될 때마다 리로드
        viewModel.onPostsUpdated = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.collectionView.reloadData()
            }
        }
        
        
    }
    
    // MARK: - Actions
    
    @objc private func didChangeModeSwitch(_ sender: UISwitch) {
        // ViewModel에 토글 요청
        viewModel.toggleDisplayMode()
    }
    
    @objc private func didTapAddButton() {
        // 우측 상단 + 버튼 눌렀을 때 동작
        //print("Add button tapped")
        let addVC = AddPostViewController()
        
        // 새 글 모드 (기본값 isEditMode = false, editingPostEntity = nil)
        // 저장 완료 시
        addVC.viewModel.onSaveSuccess = { [weak self] newPost, newEntity in
            guard let self = self else { return }
            // MainViewModel에 추가
            self.viewModel.addPost(newPost, entity: newEntity)
            self.navigationController?.popViewController(animated: true)
        }
        
        navigationController?.pushViewController(addVC, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPosts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.identifier,
            for: indexPath
        ) as? PostTableViewCell else {
            return UITableViewCell()
        }
        
        if let post = viewModel.post(at: indexPath.row) {
            cell.configure(with: post)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfPosts()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PostCollectionViewCell.identifier,
            for: indexPath
        ) as? PostCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let post = viewModel.post(at: indexPath.item) {
            cell.configure(with: post)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let post = viewModel.post(at: indexPath.row),
              let entity = viewModel.postEntity(at: indexPath.row) else { return }
        
        let addVC = AddPostViewController()
        // 수정 모드로 설정
        addVC.viewModel.configureForEdit(post: post, entity: entity, index: indexPath.row)
        
        // 콜백 설정: 수정 완료 시 호출
        addVC.viewModel.onSaveSuccess = { [weak self] updatedPost, updatedEntity in
            guard let self = self else { return }
            // 편집 인덱스 확인
            if let editingIndex = addVC.viewModel.editingIndex {
                // MainViewModel에서 업데이트
                self.viewModel.updatePost(at: editingIndex, with: updatedPost)
            }
            // 여기서 pop
            self.navigationController?.popViewController(animated: true)
        }
        
        navigationController?.pushViewController(addVC, animated: true)
    }
}


// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 탭한 셀에 해당하는 Post를 가져옴
        guard let post = viewModel.post(at: indexPath.item) else { return }
        
        let addVC = AddPostViewController()
        addVC.viewModel.configure(with: post)
        
        navigationController?.pushViewController(addVC, animated: true)
    }
}
