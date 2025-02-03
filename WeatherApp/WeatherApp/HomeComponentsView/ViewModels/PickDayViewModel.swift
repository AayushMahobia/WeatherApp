//
//  PickDayViewModel.swift
//  WeatherApp
//
//  Created by Admin on 30/01/25.
//

import Foundation

class PickDayViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
    var dayWeatherData: [List] = []
    var dailyTemperatureRange: [String: (min: Double, max: Double)] = [:]
    let options: [String] = ["Today", "Tomorrow", "Next 5 days"]
    
    
    func getWeatherData(for daysFromToday: Int, from list: [List]) -> [List] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let calendar = Calendar.current
        let targetDate = calendar.date(byAdding: .day, value: daysFromToday, to: calendar.startOfDay(for: Date()))!

        return list.filter { item in
            guard let date = dateFormatter.date(from: item.dtTxt) else {
                return false
            }
            return calendar.isDate(date, inSameDayAs: targetDate)
        }
    }
        
    func getDailyTemperatureRange(for list: [List]) -> [String: (min: Double, max: Double)] {
        var dailyTempRanges: [String: (min: Double, max: Double)] = [:]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateOnlyFormatter = DateFormatter()
        dateOnlyFormatter.dateFormat = "yyyy-MM-dd"

        for item in list {
            guard let date = dateFormatter.date(from: item.dtTxt) else { continue }
            
            let groupDayString = dateOnlyFormatter.string(from: date)
            
            let currentMin = dailyTempRanges[groupDayString]?.min ?? item.main.tempMin
            let currentMax = dailyTempRanges[groupDayString]?.max ?? item.main.tempMax
            
            dailyTempRanges[groupDayString] = (min(currentMin, item.main.tempMin), max(currentMax, item.main.tempMax))
        }
        
        return dailyTempRanges
    }

}
