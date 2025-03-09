//
//  MainViewModel.swift
//  weeklyMyContentManager
//
//  Created by 도민준 on 3/10/25.
//

import Foundation
import UIKit

enum DisplayMode {
    case table
    case collection
}

final class MainViewModel {
    
    // MARK: - Properties
    
    // 앱 내부에서 표시하기 위한 모델
    private(set) var posts: [Post] = []
    // Core Data에서 가져온 엔티티 (posts와 인덱스 동일)
    private(set) var postEntities: [PostEntity] = []
    
    // 현재 TableView로 볼지(CollectionView) 여부를 관리하는 상태
    private(set) var displayMode: DisplayMode = .table {
        didSet {
            // displayMode가 바뀌면 뷰를 업데이트하도록 bind 함수를 호출
            onDisplayModeChanged?(displayMode)
        }
    }
    
    // View에서 binding할 클로저
    var onDisplayModeChanged: ((DisplayMode) -> Void)?
    var onPostsUpdated: (() -> Void)?
    
    // MARK: - Init
    
    init() {
        //loadDummyData()
        loadPosts()
    }
    
    // MARK: - Public Methods
    
    // Core Data에서 Post 불러오기
    private func loadPosts() {
        // Core Data에서 PostEntity 객체를 가져온 후 Post 모델로 변환
        let entities = CoreDataManager.shared.fetchPosts()
        self.postEntities = entities
        
        
        self.posts = postEntities.compactMap { entity in
            // imageData -> UIImage 변환
            var image: UIImage? = nil
            if let data = entity.imageData {
                image = UIImage(data: data)
            }
            return Post(
                image: image,
                title: entity.title ?? "",
                date: entity.date ?? Date(),
                preview: entity.preview ?? ""
            )
        }
        onPostsUpdated?()
    }
    
    
    // Table <-> Collection 전환
    func toggleDisplayMode() {
        displayMode = (displayMode == .table) ? .collection : .table
    }
    
    // Post 개수
    func numberOfPosts() -> Int {
        return posts.count
    }
    
    // 특정 인덱스의 Post
    func post(at index: Int) -> Post? {
        guard index >= 0, index < posts.count else { return nil }
        return posts[index]
    }
    
    // 엔티티도 같이 반환
    func postEntity(at index: Int) -> PostEntity? {
        guard index >= 0, index < postEntities.count else { return nil }
        return postEntities[index]
    }
    
    // Post 추가
    func addPost(_ post: Post, entity: PostEntity) {
        // 새 글이 Core Data에 create된 뒤, MainViewController가 호출
        // posts, postEntities 배열에 append
        posts.append(post)
        postEntities.append(entity)
        onPostsUpdated?()
    }
    
    // 수정 시, post와 postEntities도 갱신
    func updatePost(at index: Int, with newPost: Post) {
        guard index >= 0, index < posts.count else { return }
        posts[index] = newPost
        onPostsUpdated?()
    }
    
    // MARK: - Private Methods
    
    private func loadDummyData() {
        // 테스트용 더미 데이터
        posts = [
            Post(image: UIImage(systemName: "person"),
                 title: "첫 번째 포스트",
                 date: Date(),
                 preview: "이것은 첫 번째 포스트의 미리보기입니다."),
            Post(image: UIImage(systemName: "person.fill"),
                 title: "두 번째 포스트",
                 date: Date(),
                 preview: "이것은 두 번째 포스트의 미리보기입니다.")
            // 필요한 만큼 생성
        ]
        
        // 데이터 로드가 끝나면 onPostsUpdated 호출
        onPostsUpdated?()
    }
}

