//
//  AddPostViewController.swift
//  weeklyMyContentManager
//
//  Created by 도민준 on 3/10/25.
//

import UIKit
import SnapKit

class AddPostViewController: UIViewController {
    
    // MARK: - ViewModel
    let viewModel = AddPostViewModel()
    
    // MARK: - UI Components
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .systemGray5
        iv.isUserInteractionEnabled = true // 제스처 인식
        return iv
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    private let titleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "제목을 입력하세요"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let contentTextView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 16)
        tv.textColor = .label
        tv.backgroundColor = .systemGray6
        return tv
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if viewModel.isEditMode {
            self.title = "게시글 수정"
        } else {
            self.title = "게시글 추가"
        }
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "게시물 추가"
        
        // 네비게이션 바 우측에 "완료" 버튼
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "완료",
            style: .done,
            target: self,
            action: #selector(didTapDoneButton)
        )
        
        // ImageView 탭 제스처
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImageView))
        imageView.addGestureRecognizer(tapGesture)
        
        // 서브뷰 추가
        view.addSubview(imageView)
        view.addSubview(dateLabel)
        view.addSubview(titleTextField)
        view.addSubview(contentTextView)
        
        // 초기 날짜 라벨 설정
        dateLabel.text = viewModel.dateString()
        
        // 텍스트필드 delegate
        titleTextField.delegate = self
        // 텍스트뷰 delegate
        contentTextView.delegate = self
    }
    
    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(120)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
    
    private func bindViewModel() {
        // 이미지 업데이트 시
        viewModel.onImageUpdated = { [weak self] newImage in
            self?.imageView.image = newImage
        }
        
        // 제목 업데이트 시 (ViewModel -> View)
        viewModel.onTitleUpdated = { [weak self] newTitle in
            self?.titleTextField.text = newTitle
        }
        
        // 날짜 업데이트 시
        viewModel.onDateUpdated = { [weak self] _ in
            self?.dateLabel.text = self?.viewModel.dateString()
        }
        
        // 내용 업데이트 시
        viewModel.onContentUpdated = { [weak self] newContent in
            self?.contentTextView.text = newContent
        }
        
        // 이미 ViewModel에 값이 들어있는 경우, 수동으로 UI 동기화
        imageView.image = viewModel.selectedImage
        titleTextField.text = viewModel.titleText
        dateLabel.text = viewModel.dateString()
        contentTextView.text = viewModel.contentText
    }
    
    // MARK: - Actions
    
    @objc private func didTapDoneButton() {
        // "완료" 버튼 -> viewModel.savePost() 호출
        viewModel.savePost()
    }
    
    @objc private func didTapImageView() {
        // 앨범 열기
        openPhotoLibrary()
    }
    
    private func openPhotoLibrary() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension AddPostViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.titleText = textField.text ?? ""
    }
}

// MARK: - UITextViewDelegate
extension AddPostViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.contentText = textView.text ?? ""
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        picker.dismiss(animated: true, completion: nil)
        
        if let selectedImage = info[.originalImage] as? UIImage {
            viewModel.selectedImage = selectedImage
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
