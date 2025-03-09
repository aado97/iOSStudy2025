//
//  AddPostViewModel.swift
//  weeklyMyContentManager
//
//  Created by 도민준 on 3/10/25.
//

import UIKit

final class AddPostViewModel {
    
    // 새 글 or 수정 글을 구분
    var isEditMode: Bool = false
    // 편집 중인 엔티티 (새 글 작성 시 nil)
    var editingPostEntity: PostEntity?
    // 수정 대상의 인덱스(메인 뷰에서 어떤 셀이었는지)
    var editingIndex: Int?
    
    // 새 게시물을 만들기 위해 필요한 데이터
    var selectedImage: UIImage? {
        didSet {
            onImageUpdated?(selectedImage)
        }
    }
    
    var titleText: String = "" {
        didSet {
            onTitleUpdated?(titleText)
        }
    }
    
    var date: Date = Date() {
        didSet {
            onDateUpdated?(date)
        }
    }
    
    var contentText: String = "" {
        didSet {
            onContentUpdated?(contentText)
        }
    }
    
    // 뷰 업데이트용 클로저
    var onImageUpdated: ((UIImage?) -> Void)?
    var onTitleUpdated: ((String) -> Void)?
    var onDateUpdated: ((Date) -> Void)?
    var onContentUpdated: ((String) -> Void)?
    
    // 게시물 저장(등록) 성공 시 호출할 클로저 (메인 뷰로 (post, entity)를 전달)
    var onSaveSuccess: ((Post, PostEntity) -> Void)?
    
    // MARK: - Methods
    
    func savePost() {
        if isEditMode {
            // 수정 모드: editingPostEntity가 존재해야 함
            guard let entity = editingPostEntity else { return }
            
            // entity 값 갱신
            entity.title = titleText
            entity.date = date
            entity.preview = contentText
            if let image = selectedImage {
                entity.imageData = image.jpegData(compressionQuality: 0.8)
            } else {
                entity.imageData = nil
            }
            
            // Core Data에 저장
            CoreDataManager.shared.saveContext()
            
            // 앱 내부 모델도 만들어서 콜백
            let updatedPost = Post(
                image: selectedImage,
                title: titleText,
                date: date,
                preview: contentText
            )
            
            onSaveSuccess?(updatedPost, entity)
            
        } else {
            // **새 글 작성 모드**: createPost
            if let newEntity = CoreDataManager.shared.createPost(
                title: titleText,
                date: date,
                preview: contentText,
                image: selectedImage
            ) {
                let newPost = Post(
                    image: selectedImage,
                    title: titleText,
                    date: date,
                    preview: contentText
                )
                onSaveSuccess?(newPost, newEntity)
            }
        }
    }
    
    
    // 날짜 형식 문자열
    func dateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: date)
    }
    
    func configure(with post: Post) {
        self.selectedImage = post.image
        self.titleText = post.title
        self.date = post.date
        self.contentText = post.preview
    }
    
    // "수정 모드"로 열 때, 기존 post + postEntity를 세팅
    func configureForEdit(post: Post, entity: PostEntity, index: Int) {
        self.isEditMode = true
        self.editingPostEntity = entity
        self.editingIndex = index
        
        self.selectedImage = post.image
        self.titleText = post.title
        self.date = post.date
        self.contentText = post.preview
    }
}

