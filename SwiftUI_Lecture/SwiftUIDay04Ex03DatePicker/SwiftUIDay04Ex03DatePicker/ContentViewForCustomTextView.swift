import SwiftUI

// @resultBuilder는 여러 개의 뷰 또는 데이터를 하나의 구성 요소로 조합할 수 있게 해주는 특수한 속성
// 여러 개의 뷰를 하나의 View로 합성하거나, 조건문(if, switch) 등의 코드 블록을 자동으로 변환합니다.
@resultBuilder
struct CustomViewBuilder {
    // buildBlock 메서드는 여러 개의 Text 뷰를 받아 [Text] 배열로 반환
    static func buildBlock(_ components: Text...) -> [Text] {
        components
    }
}

struct CustomTextView: View {
    // content는 @CustomViewBuilder로 선언된 뷰 빌더 속성, 클로저 형태로 [Text]를 반환
    @CustomViewBuilder var content: () -> [Text]

    var body: some View {
        VStack {  // VStack: 수직으로 뷰를 배치하는 컨테이너
            ForEach(0..<content().count, id: \.self) { index in
                // ForEach: content 배열의 인덱스를 사용해 각 Text 뷰를 순서대로 출력
                content()[index]
            }
        }
    }
}

struct ContentViewForCustomTextView: View {
    @ViewBuilder
    func dynamicContent(showImage: Bool) -> some View {
        if showImage {
            Image(systemName: "star.fill")
        }
        Text("Hello, SwiftUI!")
    }
    
    var body: some View {
        // CustomTextView를 사용해 여러 Text 뷰를 전달
        CustomTextView {
            Text("뷰 1")  // content에 포함될 Text 뷰
            Text("뷰 2")
            Text("뷰 3")
        }
        
        dynamicContent(showImage: false)
        
        /*
        let content = CustomViewBuilder.buildBlock(
            Text("뷰 1"),
            Text("뷰 2"),
            Text("뷰 3")
        )
        */
    }
}

// #Preview는 SwiftUI 캔버스에서 ContentViewForCustomTextView를 미리 보기 위한 코드
#Preview {
    ContentViewForCustomTextView()
}
