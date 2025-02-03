//
//  HomeView.swift
//  WeatherApp
//
//  Created by Admin on 28/01/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        ZStack(alignment: .top){
            // background
            Color(#colorLiteral(red: 0.1058823529, green: 0.1137254902, blue: 0.1215686275, alpha: 1))
                .ignoresSafeArea(edges: .all)
            
            // foreground
            VStack(spacing: 25){
                NavBarView(homeViewModel: homeViewModel)
                    .padding(.horizontal, 16)
                ScrollView {
                    VStack(spacing: 25){
                        TempCardView(homeViewModel: homeViewModel)
                            .padding(.horizontal, 16)
                        OtherInfoCardView(homeViewModel: homeViewModel)
                            .padding(.horizontal, 16)
                        PickDayView(homeViewModel: homeViewModel)
                            .padding(.leading, 16)
                        MapCardView(homeViewModel: homeViewModel)
                            .padding(.horizontal, 16)
                    }
                }
                .scrollIndicators(.hidden)
            }
            .redactionShimmerViewModifier(isLoading: $homeViewModel.isLoading)
        }
        .onAppear {
            Task {
                await homeViewModel.fetchWeatherData()
            }
        }
    }
}

#Preview {
    HomeView()
}
