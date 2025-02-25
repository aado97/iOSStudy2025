//
//  StatisticsViewModel.swift
//  PomoTodo
//
//  Created by 도민준 on 2/18/25.
//

import Foundation
import SwiftUI

// MARK: - 통계 뷰 모델
@Observable
class StatisticsViewModel {
  // 선택된 기간 타입 변경 (Enum)
  enum SelectedPeriod: String {
    case day = "일"
    case week = "주"
    case month = "월"
  }
  
  // 연도와 주를 포함하는 구조체 (Hashable)
  private struct YearWeek: Hashable {
    let year: Int
    let week: Int
  }
  
  // 연도와 월을 포함하는 구조체 (Hashable)
  private struct YearMonth: Hashable {
    let year: Int
    let month: Int
  }
  
  // MARK: - UI State
  struct State {
    var selectedPeriod: SelectedPeriod = .day
    var displayDate: String = ""
    
    // 🔹 UI에 표시할 통계 데이터
    var totalPomodoro: Int = 0
    var totalSessions: Double = 0
    var totalFocusTime: TimeInterval = 0
    var allFocusTime: TimeInterval = 0
    var allSessions: Double = 0
    var averageFocusTime: TimeInterval = 0
    var averageSessions: Double = 0
    var tagFocusData: [TagTimeRecord] = []
  }
  
  // MARK: - Action 정의
  enum Action {
    case updatePeriod(SelectedPeriod)  // 일간, 주간, 월간 변경
    case previousDate  // 이전 날짜 이동
    case nextDate  // 다음 날짜 이동
    case loadData  // 데이터 로드
  }
  
  // 상태 저장
  private(set) var state: State = .init()
  
  // 의존성 주입 (UseCase)
  private let pomoTodoUseCase: PomoTodoUseCase
  private let calendar = Calendar.current
  private var currentDate = Date()
  private var pomoDayData: [PomoDay] = []
  
  // MARK: - 초기화
  init(pomoTodoUseCase: PomoTodoUseCase) {
    self.pomoTodoUseCase = pomoTodoUseCase
    send(.loadData)  // 데이터 로드
  }
  
  // MARK: - Action 처리
  func send(_ action: Action) {
    switch action {
    case .updatePeriod(let period):
      state.selectedPeriod = period
      updateData()
      
    case .previousDate:
      guard let previousDate = getPreviousAvailableDate() else { return }
      currentDate = previousDate
      updateData()
      
    case .nextDate:
      guard let nextDate = getNextAvailableDate() else { return }
      currentDate = nextDate
      updateData()
      
    case .loadData:
      pomoDayData = pomoTodoUseCase.getAllPomoDays()
      updateData()
    }
  }
  
  // MARK: - 데이터 업데이트
  func updateData() {
    let filteredData = filterData(for: state.selectedPeriod)
    
    state.totalPomodoro = filteredData.reduce(0) { $0 + $1.tomatoCnt }
    state.totalSessions = filteredData.reduce(0) { $0 + $1.cycleCnt }
    state.totalFocusTime = filteredData.reduce(0) { $0 + $1.totalTime }
    
    // 전체 데이터 기준 계산
    state.allFocusTime = pomoDayData.reduce(0) { $0 + $1.totalTime }
    state.allSessions = pomoDayData.reduce(0) { $0 + $1.cycleCnt }
    
    // 기간별 평균 계산
    let (usedDays, usedWeeks, usedMonths) = getUsedPeriods()
    
    state.averageFocusTime = state.allFocusTime / Double(max(1, usedDays))
    state.averageSessions = state.allSessions / Double(max(1, usedDays))
    
    switch state.selectedPeriod {
    case .week:
      state.averageFocusTime = state.allFocusTime / Double(max(1, usedWeeks))
      state.averageSessions = state.allSessions / Double(max(1, usedWeeks))
    case .month:
      state.averageFocusTime = state.allFocusTime / Double(max(1, usedMonths))
      state.averageSessions = state.allSessions / Double(max(1, usedMonths))
    case .day:
      break
    }
    
    // 태그별 집중시간 데이터 정렬
    state.tagFocusData = aggregateTagFocusTime(from: filteredData)
    state.tagFocusData.sort { (tag1, tag2) in
      let appTags = pomoTodoUseCase.getAppConfig().tags
      let index1 = appTags.first { $0.id == tag1.tagId }?.index ?? Int.max
      let index2 = appTags.first { $0.id == tag2.tagId }?.index ?? Int.max
      return index1 < index2
    }
    updateDisplayDate()
  }
  
  // MARK: - 사용한 기간(일/주/월) 계산
  private func getUsedPeriods() -> (days: Int, weeks: Int, months: Int) {
    let usedDays = Set(pomoDayData.map { calendar.startOfDay(for: $0.date) })
    let usedWeeks = Set(pomoDayData.map {
      YearWeek(year: calendar.component(.year, from: $0.date),
               week: calendar.component(.weekOfYear, from: $0.date))
    })
    let usedMonths = Set(pomoDayData.map {
      YearMonth(year: calendar.component(.year, from: $0.date),
                month: calendar.component(.month, from: $0.date))
    })
    
    return (usedDays.count, usedWeeks.count, usedMonths.count)
  }
  
  // MARK: - 태그별 집중 시간 계산
  private func aggregateTagFocusTime(from pomoDays: [PomoDay]) -> [TagTimeRecord] {
    var tagMap: [String: TimeInterval] = [:]
    for day in pomoDays {
      for record in day.tagTimeRecords {
        tagMap[record.tagId, default: 0] += record.focusTime
      }
    }
    return tagMap.map { TagTimeRecord(tagId: $0.key, focusTime: $0.value) }
  }
  
  // MARK: - 데이터 필터링 (선택된 기간별)
  private func filterData(for period: SelectedPeriod) -> [PomoDay] {
    return pomoDayData.filter { day in
      switch period {
      case .day:
        return calendar.isDate(day.date, inSameDayAs: currentDate)
      case .week:
        guard let weekStart = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start else { return false }
        guard let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart) else { return false }
        return day.date >= weekStart && day.date <= weekEnd
      case .month:
        return calendar.isDate(day.date, equalTo: currentDate, toGranularity: .month)
      }
    }
  }
  
  // MARK: - 날짜 포맷 업데이트
  private func updateDisplayDate() {
    let dateFormatter = DateFormatter()
    
    switch state.selectedPeriod {
    case .day:
      dateFormatter.dateFormat = "YYYY년 M월 d일"
      state.displayDate = dateFormatter.string(from: currentDate)
    case .week:
      guard let weekStart = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start else { return }
      guard let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart) else { return }
      dateFormatter.dateFormat = "M월 d일"
      state.displayDate = "\(dateFormatter.string(from: weekStart)) - \(dateFormatter.string(from: weekEnd))"
    case .month:
      dateFormatter.dateFormat = "YYYY년 M월"
      state.displayDate = dateFormatter.string(from: currentDate)
    }
  }
  
  // MARK: - 날짜 이동
  //저장된 데이터가 있는 날짜만 이동
  func previousDate() {
    guard let previousDate = getPreviousAvailableDate() else { return }
    currentDate = previousDate
    updateData()
  }
  
  func nextDate() {
    guard let nextDate = getNextAvailableDate() else { return }
    currentDate = nextDate
    updateData()
  }
  
  // MARK: - 레포지토리로 이동
  // 이전 날짜
  func getPreviousAvailableDate() -> Date? {
    let sortedDates = pomoDayData.map { $0.date }.sorted(by: >) // 최신순 정렬
    
    switch state.selectedPeriod {
    case .day:
      return sortedDates.first(where: { $0 < currentDate }) // 가장 가까운 과거 날짜
      
    case .week:
      let currentWeek = calendar.component(.weekOfYear, from: currentDate)
      let currentYear = calendar.component(.year, from: currentDate)
      
      return sortedDates.first(where: { date in
        let week = calendar.component(.weekOfYear, from: date)
        let year = calendar.component(.year, from: date)
        return year < currentYear || (year == currentYear && week < currentWeek)
      })
      
    case .month:
      let currentYearMonth = (calendar.component(.year, from: currentDate) * 100) + calendar.component(.month, from: currentDate)
      
      return sortedDates.first(where: { date in
        let yearMonth = (calendar.component(.year, from: date) * 100) + calendar.component(.month, from: date)
        return yearMonth < currentYearMonth // 현재 연월보다 작은 가장 가까운 데이터 찾기
      })
    }
  }
  
  // 다음 날짜
  func getNextAvailableDate() -> Date? {
    let sortedDates = pomoDayData.map { $0.date }.sorted(by: <) // 과거순 정렬
    
    switch state.selectedPeriod {
    case .day:
      return sortedDates.first(where: { $0 > currentDate }) // 가장 가까운 미래 날짜
      
    case .week:
      let currentWeek = calendar.component(.weekOfYear, from: currentDate)
      let currentYear = calendar.component(.year, from: currentDate)
      
      return sortedDates.first(where: { date in
        let week = calendar.component(.weekOfYear, from: date)
        let year = calendar.component(.year, from: date)
        return year > currentYear || (year == currentYear && week > currentWeek)
      })
      
    case .month:
      let currentYearMonth = (calendar.component(.year, from: currentDate) * 100) + calendar.component(.month, from: currentDate)
      
      return sortedDates.first(where: { date in
        let yearMonth = (calendar.component(.year, from: date) * 100) + calendar.component(.month, from: date)
        return yearMonth > currentYearMonth // 현재 연월보다 큰 가장 가까운 데이터 찾기
      })
    }
  }
  
  // 태그 ID를 기반으로 태그 이름 찾기
  func getTagName(for tagId: String) -> String {
    return pomoTodoUseCase.getAppConfig().tags.first { $0.id == tagId }?.name ?? "Unknown"
  }
  
  // 태그 ID 기반으로 색상 찾기
  func getTagColor(for tagId: String) -> Color {
    guard let colorId = pomoTodoUseCase.getAppConfig().tags.first(where: { $0.id == tagId })?.colorId,
          let colorSet = Constants.Timer.colorSets.first(where: { $0.id == colorId }) else {
      return .gray // 기본 색상 (예외 처리)
    }
    return colorSet.normalColor
  }
  
  
  
  //  @Published var selectedPeriod: String = "일"
  //  @Published var displayDate: String = ""
  //
  //  //  UI 데이터 저장
  //  @Published var totalPomodoro: Int = 0
  //  @Published var totalSessions: Double = 0
  //  @Published var totalFocusTime: TimeInterval = 0
  //  @Published var allFocusTime: TimeInterval = 0
  //  @Published var allSessions: Double = 0
  //  @Published var averageFocusTime: TimeInterval = 0
  //  @Published var averageSessions: Double = 0
  //  @Published var tagFocusData: [TagTimeRecord] = []
  //
  //  private let calendar = Calendar.current
  //  private var currentDate = Date()
  //  private var pomoDayData: [PomoDay] = []
  //  private let pomoTodoUseCase: PomoTodoUseCase
  //
  //  init(pomoTodoUseCase: PomoTodoUseCase) {
  //    self.pomoTodoUseCase = pomoTodoUseCase
  //    loadPomoData()
  //  }
  //
  //  // 저장된 포모도로 데이터 불러오기
  //  private func loadPomoData() {
  //    self.pomoDayData = pomoTodoUseCase.getAllPomoDays()
  //    updateData()
  //  }
  
  
  //  // 데이터 필터링 후 업데이트
  //  func updateData() {
  //    let filteredData = filterData(for: selectedPeriod)
  //
  //    totalPomodoro = filteredData.reduce(0) { $0 + $1.tomatoCnt }
  //    totalSessions = filteredData.reduce(0) { $0 + $1.cycleCnt }
  //    totalFocusTime = filteredData.reduce(0) { $0 + $1.totalTime }
  //
  //    // 전체 누적된 데이터 기준으로 총 집중시간과 세션 계산
  //    allFocusTime = pomoDayData.reduce(0) { $0 + $1.totalTime }
  //    allSessions = pomoDayData.reduce(0) { $0 + $1.cycleCnt }
  //
  //    // 사용한 일/주/월 수 가져오기 (실제 데이터 존재하는 기간 기준)
  //    let (usedDays, usedWeeks, usedMonths) = getUsedPeriods()
  //
  //    // 기본적으로 "일간 평균" 계산
  //    averageFocusTime = allFocusTime / Double(max(1, usedDays))
  //    averageSessions = allSessions / Double(max(1, usedDays))
  //
  //    // 선택된 기간이 "주"라면 주간 기준으로 나눔
  //    if selectedPeriod == "주" {
  //      averageFocusTime = allFocusTime / Double(max(1, usedWeeks))
  //      averageSessions = allSessions / Double(max(1, usedWeeks))
  //    }
  //
  //    // 선택된 기간이 "월"이라면 월간 기준으로 나눔
  //    if selectedPeriod == "월" {
  //      averageFocusTime = allFocusTime / Double(max(1, usedMonths))
  //      averageSessions = allSessions / Double(max(1, usedMonths))
  //    }
  //
  //    print("사용한 총 일수: \(usedDays), 주 수: \(usedWeeks), 월 수: \(usedMonths)")
  //    print("평균 집중 시간 (일간 기준): \(averageFocusTime.formattedTime())")
  //    print("평균 세션 (일간 기준): \(averageSessions)")
  //
  //    // 태그별 집중시간 데이터 정렬
  //    tagFocusData = aggregateTagFocusTime(from: filteredData)
  //    tagFocusData.sort { (tag1, tag2) in
  //      let appTags = pomoTodoUseCase.getAppConfig().tags
  //      let index1 = appTags.first { $0.id == tag1.tagId }?.index ?? Int.max
  //      let index2 = appTags.first { $0.id == tag2.tagId }?.index ?? Int.max
  //      return index1 < index2
  //    }
  //
  //    updateDisplayDate()
  //  }
  
  // 실제 사용한 "주"와 "월" 개수 반환
  //  private func getUsedPeriods() -> (days: Int, weeks: Int, months: Int) {
  //    let usedDays = Set(pomoDayData.map { calendar.startOfDay(for: $0.date) })
  //
  //    // 연도 + 주를 묶어서 Set에 저장
  //    let usedWeeks = Set(pomoDayData.map {
  //      YearWeek(year: calendar.component(.year, from: $0.date),
  //               week: calendar.component(.weekOfYear, from: $0.date))
  //    })
  //
  //    // 연도 + 월을 묶어서 Set에 저장
  //    let usedMonths = Set(pomoDayData.map {
  //      YearMonth(year: calendar.component(.year, from: $0.date),
  //                month: calendar.component(.month, from: $0.date))
  //    })
  //
  //    return (usedDays.count, usedWeeks.count, usedMonths.count)
  //  }
  //
  
  // 태그별 집중시간 계산
  //  private func aggregateTagFocusTime(from pomoDays: [PomoDay]) -> [TagTimeRecord] {
  //    var tagMap: [String: TimeInterval] = [:]
  //    for day in pomoDays {
  //      for record in day.tagTimeRecords {
  //        tagMap[record.tagId, default: 0] += record.focusTime
  //      }
  //    }
  //    return tagMap.map { TagTimeRecord(tagId: $0.key, focusTime: $0.value) }
  //  }
  //
  //  // 날짜 필터링 함수
  //  private func filterData(for period: String) -> [PomoDay] {
  //    return pomoDayData.filter { day in
  //      switch period {
  //      case "일":
  //        return calendar.isDate(day.date, inSameDayAs: currentDate)
  //      case "주":
  //        guard let weekStart = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start else { return false }
  //        guard let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart) else { return false }
  //
  //        return day.date >= weekStart && day.date <= weekEnd
  //      case "월":
  //        return calendar.isDate(day.date, equalTo: currentDate, toGranularity: .month)
  //      default:
  //        return false
  //      }
  //    }
  //  }
  
  // 날짜 업데이트 함수 (주간 & 월간 날짜 표시 수정)
  //  private func updateDisplayDate() {
  //    let dateFormatter = DateFormatter()
  //
  //    switch selectedPeriod {
  //    case "일":
  //      dateFormatter.dateFormat = "YYYY년 M월 d일"
  //      displayDate = dateFormatter.string(from: currentDate)
  //
  //    case "주":
  //      // 🔥 주간 범위 표시 수정
  //      guard let weekStart = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start else { return }
  //      guard let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart) else { return }
  //
  //      dateFormatter.dateFormat = "M월 d일"
  //      displayDate = "\(dateFormatter.string(from: weekStart)) - \(dateFormatter.string(from: weekEnd))"
  //
  //    case "월":
  //      dateFormatter.dateFormat = "YYYY년 M월"
  //      displayDate = dateFormatter.string(from: currentDate)
  //
  //    default:
  //      break
  //    }
  //  }
}
