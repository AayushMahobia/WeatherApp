//
//  PickDayView.swift
//  WeatherApp
//
//  Created by Admin on 29/01/25.
//

import SwiftUI

struct PickDayView: View {
    
    @State var selectedTab: String = "Today"
    @State var options: [String] = ["Today", "Tomorrow", "Next 10 days"]
    
    var body: some View {
        ZStack(alignment: .top){
            Color(#colorLiteral(red: 0.1058823529, green: 0.1137254902, blue: 0.1215686275, alpha: 1))
            
            VStack(spacing: 25){
                
                // Tabs
                HStack(spacing: 25){
                    ForEach(options, id: \.self) { option in
                        VStack(spacing: 6) {
                            Text(option)
                                .onTapGesture {
                                    selectedTab = option
                                }
                                .font(.headline)
                                .foregroundStyle(selectedTab == option ? .white : .gray)
                            Image(systemName: "circle.fill")
                                .font(.system(size: 6))
                                .foregroundStyle(selectedTab == option ? .white : Color(#colorLiteral(red: 0.1058823529, green: 0.1137254902, blue: 0.1215686275, alpha: 1)))
                        }
                    }
                    Spacer()
                }
                
                // Cards
                ScrollView(.horizontal){
                    HStack(spacing: 15){
                        ForEach(0..<5){ _ in
                            HourCardView()
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .frame(height: 200)
        .padding(.top, 10)
    }
}

//#Preview {
//    PickDayView()
//}
