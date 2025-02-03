//
//  NavBarView.swift
//  WeatherApp
//
//  Created by Admin on 28/01/25.
//

import SwiftUI

struct NavBarView: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack(alignment: .top){
            Color(#colorLiteral(red: 0.1058823529, green: 0.1137254902, blue: 0.1215686275, alpha: 1))
            
            HStack{
                VStack(alignment: .leading, spacing: 5) {
                    Text(homeViewModel.getCityName())
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Text(homeViewModel.formatDate(homeViewModel.weatherData?.list[0].dtTxt ?? "", inputFormat: "yyyy-MM-dd HH:mm:ss", outputFormat: "d MMMM, EEEE"))
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                        .fontWeight(.semibold)
                }
                Spacer()
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(#colorLiteral(red: 0.1512033641, green: 0.164224118, blue: 0.1817708015, alpha: 1)))
                    .frame(width: 40, height: 40)
                    .overlay {
                        Image(systemName: "square.grid.2x2.fill")
                            .font(.title3)
                            .foregroundStyle(.white)
                    }
            }
        }
        .frame(height: 50)
    }
}

//#Preview {
//    NavBarView()
//}
