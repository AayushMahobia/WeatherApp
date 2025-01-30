//
//  TempCardView.swift
//  WeatherApp
//
//  Created by Admin on 28/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct TempCardView: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
//    let imageURL = "https://openweathermap.org/img/wn/\(homeViewModel.weatherData?.list[0].weather[0].icon).png"

    var body: some View {
        ZStack(alignment: .top){
            Color(#colorLiteral(red: 0.1058823529, green: 0.1137254902, blue: 0.1215686275, alpha: 1))
            
            HStack{
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(homeViewModel.getCurrentTemperature())")
                        .font(.system(size: 70))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Text(homeViewModel.weatherData?.list[0].weather[0].description.rawValue.capitalized ?? "Some Description")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                }
                Spacer()
                VStack{
                    WebImage(url: homeViewModel.getImageURL("\(homeViewModel.weatherData?.list[0].weather[0].icon ?? "Image")"))
                        .resizable()
                        .frame(width: 110, height: 110)
                }
                    
            }
            .padding(.horizontal, 20)
        }
        .frame(height: 110)
//        .onAppear{
//            Task{
//                await homeViewModel.fetchWeatherData()
//            }
//        }
    }
}

#Preview {
    TempCardView(homeViewModel: HomeViewModel())
}
