//
//  NotificationManager.swift
//  SwiftUIReflectionSystem
//
//  Created by 도민준 on 2/14/25.
//

import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("알림 권한 허용")
            } else {
                print("알림 권한 거부")
            }
        }
    }
    
    func scheduleDailyReflectionReminder() {
        let content = UNMutableNotificationContent()
        content.title = "오늘의 회고를 작성하세요!"
        content.body = "하루를 돌아보고 간단히 기록하세요."
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 20
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyReflectionReminder", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("알람 예약 실패: \(error)")
            } else {
                print("알람 예약 성공")
            }
        }
    }
}
