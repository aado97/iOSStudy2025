import SwiftUI

struct MyCustomView: View {
    @ViewBuilder
    func createContent(showTitle: Bool) -> some View {
        if showTitle {
            Text("타이틀 표시")
        }
        // @ViewBuiler 프로퍼티는 다중 뷰 사용 가능
        Text("항상 표시되는 내용")
        Text("항상 표시되는 내용2")
    }
    
    // 비교
    func someFunction() -> some View {
        Text("someFunction1")
        // 다중 뷰 사용 불가능
        // Text("someFunction2")
    }

    var body: some View {
        VStack {
            createContent(showTitle: true)
            createContent(showTitle: false)
            someFunction()
            someFunction()
        }
    }
}

#Preview {
    MyCustomView()
}
