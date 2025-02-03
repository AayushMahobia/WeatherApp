//
//  PickDayView.swift
//  WeatherApp
//
//  Created by Admin on 29/01/25.
//

import SwiftUI

struct PickDayView: View {
    @StateObject var pickDayViewModel: PickDayViewModel = PickDayViewModel()
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack(alignment: .top){
            Color(#colorLiteral(red: 0.1058823529, green: 0.1137254902, blue: 0.1215686275, alpha: 1))
            
            VStack(spacing: 25){
                
                // Tabs
                HStack(spacing: 25){
                    ForEach(pickDayViewModel.options.indices, id: \.self) { index in
                        VStack(spacing: 6) {
                            Text(pickDayViewModel.options[index])
                                .onTapGesture {
                                    pickDayViewModel.selectedTab = index
                                    if index == 2{
                                        pickDayViewModel.dailyTemperatureRange = pickDayViewModel.getDailyTemperatureRange(for: homeViewModel.weatherData?.list ?? [])
                                    } else{
                                        pickDayViewModel.dayWeatherData = pickDayViewModel.getWeatherData(for: pickDayViewModel.selectedTab, from: homeViewModel.weatherData?.list ?? [])
                                    }
                                }
                                .font(.headline)
                                .foregroundStyle(pickDayViewModel.selectedTab == index ? .white : .gray)
                            Image(systemName: "circle.fill")
                                .font(.system(size: 6))
                                .foregroundStyle(pickDayViewModel.selectedTab == index ? .white : Color(#colorLiteral(red: 0.1058823529, green: 0.1137254902, blue: 0.1215686275, alpha: 1)))
                        }
                    }
                    Spacer()
                }

                
                // Cards
                ScrollView(.horizontal){
                    HStack(spacing: 15){
                        if pickDayViewModel.selectedTab == 2{
                            ForEach(pickDayViewModel.dailyTemperatureRange.sorted(by: { $0.key < $1.key }), id: \.key) { day, range in
                                DayCardView(homeViewModel: homeViewModel ,day: day, range: range)
                            }
                        } else{
                            ForEach(pickDayViewModel.dayWeatherData, id: \.dt) { dayWeather in
                                HourCardView(homeViewModel: homeViewModel ,dayWeather: dayWeather)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                
            }
        }
        .frame(height: 200)
        .padding(.top, 10)
        .onAppear(){
            pickDayViewModel.selectedTab = 0
            pickDayViewModel.dayWeatherData = pickDayViewModel.getWeatherData(for: pickDayViewModel.selectedTab, from: homeViewModel.weatherData?.list ?? [])
        }
    }
}

#Preview {
    PickDayView(homeViewModel: HomeViewModel())
}
