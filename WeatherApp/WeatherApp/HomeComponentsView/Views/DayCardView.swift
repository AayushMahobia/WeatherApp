//
//  DayCardView.swift
//  WeatherApp
//
//  Created by Admin on 31/01/25.
//

import SwiftUI

struct DayCardView: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    let day: String
    let range: (Double, Double)
    
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.1512033641, green: 0.164224118, blue: 0.1817708015, alpha: 1))
            
            VStack(spacing: 20){
                Text("\(homeViewModel.formatDecimal(homeViewModel.kelvinToCelsius(range.0)))°")
                    .foregroundStyle(.blue)
                Text("\(homeViewModel.formatDate(day, inputFormat: "yyyy-MM-dd", outputFormat: "EEEE").prefix(3))")
                    .foregroundStyle(.white)
                    .font(.title2)
                Text("\(homeViewModel.formatDecimal(homeViewModel.kelvinToCelsius(range.1)))°")
                    .foregroundStyle(.red)
                    
            }
            .font(.title3)
            .fontWeight(.semibold)
        }
        .frame(width: 100, height: 130)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

//#Preview {
//    DayCardView()
//}
