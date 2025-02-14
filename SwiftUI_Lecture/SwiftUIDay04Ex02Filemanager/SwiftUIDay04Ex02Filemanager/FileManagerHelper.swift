//
//  FileManagerHelper.swift
//  SwiftUIDay04Ex02Filemanager
//
//  Created by 도민준 on 2/13/25.
//

import SwiftUI

// VO, DTO 또는 Java의 Bean
// 다른 뷰 파일에서도 접근 가능한 전역 선언.
struct User: Codable {
    var id: UUID
    var name: String
    var age: Int
}


// 데이터를 저장하고 불러오는 역할
// 외부에서 데이터를 변경해야하기 떄문에 참조형으로 선언
class FileManagerHelper {
    // 싱글톤 : 이 클래스의 객체는 오직 하나뿐이다.
    // FileManagerHelper.shared 멤버
    static let shared = FileManagerHelper()
    // 저장할 파일 이름
    private let fileName = "users.json"
    
    // JSON 파일로 저장
    func saveUsers(_ users: [User]) {
        // Document 디렉토리의 경로를 가져옴 (앱 전용 사용자 데이터 저장 경로)
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print("documentDirectory: \(documentDirectory)")
        let fileURL = documentDirectory.appendingPathComponent(fileName)    // 파일 경로 생성
        
        let encoder = JSONEncoder() // JSON 인코더 생성
        if let data = try? encoder.encode(users) {
            do {
                try data.write(to: fileURL) // 데이터를 파일에 저장
                print("데이터 저장 성공: \(fileURL)")  // 저장 성공 메시지 출력
            } catch {
                print("저장 실패: \(error)")    // 저장 실패 시 오류 메시지 출력
            }
        }
        
    }
    
    // JSON 문자열을 배열로 불러오기
    func loadUsers() -> [User] {
        // Document 디렉토리의 경로와 저장된 파일의 경로 생성
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        if let data = try? Data(contentsOf: fileURL) {  // 파일에서 데이터를 읽어옴
            let decoder = JSONDecoder() // JSON 디코더 생성
            if let users = try? decoder.decode([User].self, from: data) {   // JSON 데이터를 User 배열로 변환
                print("데이터 불러오기 성공")
                return users    // 변환된 User 배열 변환
            }
        }
        print("데이터 불러오기 실패")
        return []   // 데이터 불러오기 실패 시 빈배열 반환
    }
}
