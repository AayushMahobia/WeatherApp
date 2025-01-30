//
//  OtherInfoCardView.swift
//  WeatherApp
//
//  Created by Admin on 28/01/25.
//

import SwiftUI

struct OtherInfoCardView: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.1512033641, green: 0.164224118, blue: 0.1817708015, alpha: 1))
            
            HStack{
                VStack(spacing: 6){
                    Image(systemName: "wind.circle.fill")
                    Text("\(homeViewModel.formatDecimal(homeViewModel.weatherData?.list[0].wind.speed ?? 0)) m/s")
                        .font(.headline)
                    Text("Wind")
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                        .fontWeight(.semibold)
                }
                Spacer()
                VStack(spacing: 6){
                    Image(systemName: "drop.fill")
                        .foregroundStyle(.blue)
                    Text("\(homeViewModel.weatherData?.list[0].main.humidity ?? 0)%")
                        .font(.headline)
                    Text("Humidity")
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                        .fontWeight(.semibold)
                }
                Spacer()
                VStack(spacing: 6){
                    Image(systemName: "umbrella.fill")
                        .foregroundStyle(.purple)
                    Text("\(homeViewModel.formatDecimal((homeViewModel.weatherData?.list[0].pop ?? 0) * 100))%")
                        .font(.headline)
                    Text("Rain")
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                        .fontWeight(.semibold)
                }
            }
            .foregroundStyle(.white)
            .padding(.vertical)
            .padding(.horizontal, 30)
        }
        .frame(height: 110)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

//#Preview {
//    OtherInfoCardView()
//}
