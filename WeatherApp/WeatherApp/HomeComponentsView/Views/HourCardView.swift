//
//  HourCardView.swift
//  WeatherApp
//
//  Created by Admin on 29/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct HourCardView: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    let dayWeather: List
    
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.1512033641, green: 0.164224118, blue: 0.1817708015, alpha: 1))
            
            VStack(spacing: 12){
                Text("\(homeViewModel.formatDate(dayWeather.dtTxt, inputFormat: "yyyy-MM-dd HH:mm:ss", outputFormat: "h a"))")
                    .foregroundStyle(.gray)
                WebImage(url: homeViewModel.getImageURL(dayWeather.weather[0].icon))
                    .resizable()
                    .frame(width: 40, height: 40)
                Text("\(homeViewModel.formatDecimal(homeViewModel.kelvinToCelsius(dayWeather.main.temp)))°")
                    .foregroundStyle(.white)
                    .font(.title3)
            }
            .fontWeight(.semibold)
        }
        .frame(width: 100, height: 130)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

//#Preview {
//    HourCardView()
//}

