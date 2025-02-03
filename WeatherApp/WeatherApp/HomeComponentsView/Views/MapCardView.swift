//
//  MapCardView.swift
//  WeatherApp
//
//  Created by Admin on 29/01/25.
//

import SwiftUI

struct MapCardView: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.1512033641, green: 0.164224118, blue: 0.1817708015, alpha: 1))
            
            Text(homeViewModel.getCityName())
                .foregroundStyle(.gray)
                .font(.headline)
        }
        .frame(height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

#Preview {
    MapCardView(homeViewModel: HomeViewModel())
}
