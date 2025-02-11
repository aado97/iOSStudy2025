import SwiftUI

struct ContentView: View {
    @State private var words: [String] = ["사과", "딸기", "바나나"]   // 단어를 저장할 배열
    @State private var newWord: String = ""  // 새로 입력할 단어
    @State private var wordToDelete: String = "" // 삭제할 단어
    @State private var wordToSearch: String = "" // 검색할 단어
    @State private var message: String = "단어를 추가하세요"  // 상태 메시지
    
    func addWord() {
        if newWord.isEmpty {
            message = "단어를 입력하세요."
        } else if words.contains(newWord) {
            message = "이미 존재하는 단어입니다."
        } else {
            print("추가 버튼 누름", newWord)
            // words는 State이므로 상태 값이 변경되면 자동 재랜더링.
            withAnimation {
                words.append(newWord)
            }
            
            newWord = ""
            message = "새 단어가 추가 되었습니다."
        }
    }
    
    func removeWord() {
        print("삭제 버튼 누름", wordToDelete)
        // 입력 된 단어와 일치하는 단어를 words에서 찾기: firstIndex(of: )
        // 목록에서 해당 단어 삭제: remove()
        if let index = words.firstIndex(of: wordToDelete) {
            words.remove(at: index)
            message = "단어 목록에서 \(wordToDelete)를 삭제했습니다."
            wordToDelete = ""
        } else {
            message = "단어 목록에 \(wordToDelete)는 없습니다."
        }
    }
    
    func searchWord() {
        if let index = words.firstIndex(of: wordToSearch) {
            message = "\(wordToSearch)는 배열의 \(index + 1)번째 위치에 있습니다."
        } else {
            message = "단어 목록에 \(wordToSearch)는 없습니다."
        }
    }
    
    var body: some View {
        VStack {
            Text ("단어 관리 프로그램")
                .font(.largeTitle)
                .padding()
            HStack {
                TextField("단어 입력", text: $newWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("추가") {
                    addWord()
                }
            }
            .padding()
            
            ZStack(alignment: .bottomTrailing) {
                List {
                    ForEach(words, id: \.self) { word in
                        Text(word)
                            .transition(.opacity)
                    }
                }
                Text("현재 단어 수: \(words.count)개")
                    .padding()
            }
            
            HStack {
                TextField("단어 삭제", text: $wordToDelete)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("삭제") {
                    removeWord()
                }
                .padding(.horizontal)
            }
            
            HStack {
                TextField("단어 검색", text: $wordToSearch)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("검색") {
                    searchWord()
                }
                .padding(.horizontal)
            }
            
            Text(message)
                .foregroundStyle(.red)
                .padding()
        } // end VStack
        .padding()
        
        
    }
}

struct ArrayManagerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
