import SwiftUI

struct StatisticsView: View {
    @State private var selectedPeriod = "주"
    let periods = ["날짜", "주", "월"]
    
    var body: some View {
        VStack(spacing: 20) {
            
            // 📌 Segmented Control
            Picker("기간 선택", selection: $selectedPeriod) {
                ForEach(periods, id: \.self) { period in
                    Text(period).tag(period)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            // 📌 첫 번째 섹션 (누적 포모도로 & 누적 세션)
            RoundedSectionView {
                HStack {
                    VStack {
                        Text("누적 포모도로")
                            .font(.headline)
                        Text("18")
                            .font(.largeTitle)
                            .bold()
                    }
                    Spacer()
                    VStack {
                        Text("누적 세션")
                            .font(.headline)
                        Text("8")
                            .font(.largeTitle)
                            .bold()
                    }
                }
                .padding()
            }
            
            // 📌 두 번째 섹션 (집중 시간 & 바 차트)
            RoundedSectionView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("주간 집중 시간")
                            .font(.headline)
                        Spacer()
                        Text("12h 24m")
                            .font(.title2)
                            .bold()
                    }
                    
                    // 바 차트 (예제)
                    ProgressBarView(percentage: 50, color: .blue, title: "취미", time: "4h 12m")
                    ProgressBarView(percentage: 30, color: .indigo, title: "공부", time: "2h 59m")
                    ProgressBarView(percentage: 20, color: .cyan, title: "독서", time: "1h 24m")
                    ProgressBarView(percentage: 10, color: .teal, title: "운동", time: "49m")
                }
                .padding()
            }
            
            // 📌 세 번째 섹션 (주간 평균 데이터)
            RoundedSectionView {
                HStack {
                    VStack {
                        Text("주간 평균 세션")
                            .font(.headline)
                        Text("17")
                            .font(.largeTitle)
                            .bold()
                    }
                    Spacer()
                    VStack {
                        Text("주간 평균 집중 시간")
                            .font(.headline)
                        Text("26.5")
                            .font(.largeTitle)
                            .bold()
                    }
                }
                .padding()
            }

            Spacer()
        }
        .padding(.horizontal)
    }
}

// 📌 **RoundedSectionView: 공통 섹션 스타일**
struct RoundedSectionView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.systemGray6)) // 배경색 (연한 회색)
            )
            .padding(.horizontal)
    }
}

// 📌 **ProgressBarView: 바 차트 스타일**
struct ProgressBarView: View {
    var percentage: CGFloat
    var color: Color
    var title: String
    var time: String
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .frame(width: percentage * 2, height: 20)
            
            Text(title)
                .font(.subheadline)
                .padding(.leading, 8)
            
            Spacer()
            
            Text(time)
                .font(.subheadline)
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
