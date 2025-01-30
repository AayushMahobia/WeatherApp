//
//  HourCardView.swift
//  WeatherApp
//
//  Created by Admin on 29/01/25.
//

import SwiftUI

struct HourCardView: View {
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.1512033641, green: 0.164224118, blue: 0.1817708015, alpha: 1))
            
            VStack(spacing: 12){
                Text("10 am")
                    .foregroundStyle(.gray)
                Image(systemName: "sun.min.fill")
                    .foregroundStyle(.yellow)
//                    .font(.system(size: 40))
                    .font(.largeTitle)
                Text("16°")
                    .foregroundStyle(.white)
                    .font(.title3)
            }
            .fontWeight(.semibold)
        }
        .frame(width: 100, height: 130)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    HourCardView()
}
