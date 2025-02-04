
// 구조체
struct Example {
    
    // 가장 기본적인 함수 선언
    // 키워드 + 이름 + 인자 + 몸체
    // func 함수명() {}
    // 실행하는 파일에서 구조체 생성 + 함수(메서드) 호출
    // Example().run()
    // let exam = Example()
    // exam.run()
    func run() {
        let monthDays: [Int] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        var month: Int = 0
        var day: Int = 0
        var total: Int = 0
        var nextMonth = 0
        var nextDay = 0
        var afterDay = 0
        
        // 월, 일 입력
        print("월 입력:", terminator: " ")
        month = Int(readLine() ?? "") ?? 0
        print("일 입력:", terminator: " ")
        day = Int(readLine() ?? "") ?? 0
        
        print("입력 된 날짜는 \(month)월 \(day)일입니다.")
        
        print("며칠 후 날짜를 구할까요?", terminator: " ")
        afterDay = Int(readLine() ?? "") ?? 0
        // 문제2) 월,일을 입력 받아서 100일 후의 월,일출력. (난이도: 고)
        // 월 입력: 11월
        // 일 입력: 21
        // 11월 21일의 100일 후는 O월 O일입니다.
        
        // 방법1: total을 100으로 초기화하고 total 0보다 작을떄까지 빼준다.
        // 1. total을 100으로 초기화
        // 2. 현재월의 남은 날짜 만큼을 total에서 뺀다.
        // 3. 현재달의 다음달부터는 total이 음수가 되기 전까지 뺀다. (반복문 탈출 조건)
        // 4. total의 남은 일수가 nextDay가 된다.
        // 5. nextMonth가 된다.
        /*
         total = 100 - (monthDays[month - 1] - day)
         var i = month
         i = i % monthDays.count
         while total > monthDays[i] {
         total = total - monthDays[i]
         i = i + 1
         i = i % monthDays.count
         }
         nextDay = total
         nextMonth = i + 1
         */
        
        // 방법2: total이 100이상이 될떄까지 누적한다.
        // 1. 현재월의 남은 날짜로 total 초기화 하기
        // 2. 다음 월부터는 반복해서 해당 월의 전체 날짜를 반복해서 누적한다.
        // 3. total이 100보다 커지면 반복문 탈출
        // 4. 탈출한 월의 전체 날짜에서 100보다 큰만큼을 빼면 nextDay
        // 5. nextMonth는 탈출 시점의 index + 1 된다.
        var i = month
        i = i % monthDays.count
        if afterDay < monthDays[month - 1] - day {
            nextDay = day + afterDay
            nextMonth = i
        } else {
            total = monthDays[month - 1] - day
            print(total)
//            while total < afterDay {
//                i = i % monthDays.count
//                total = total + monthDays[i]
//                print("month : \(i + 1)월")
//                print(total)
//                i += 1
//                
//            }
//            while total < afterDay {
//                total += monthDays[i]
//                print(total)
//                i += 1
//                i = i % monthDays.count
//            }
//            
//            // 최종 날짜 계산
//            nextDay = monthDays[i-1] - (total - afterDay)
//            nextMonth = i
            
//            i = i - 1
//            i %= 12
//            total = total - afterDay
//            if total < monthDays[i] {
//                nextDay = total
//                nextMonth = i
//            } else {
//                nextDay = total - monthDays[i]
//                nextMonth = i + 1
//            }
            
            print(total)
            
            
        }
        
        
        print("\(month)월 \(day)일의 \(afterDay)일 후는 \(nextMonth)월 \(nextDay)일입니다.")
    }
}
