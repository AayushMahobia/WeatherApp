//
//  ShimmerView.swift
//  WeatherApp
//
//  Created by Admin on 30/01/25.
//

// Created By Me, not used in this project
import SwiftUI

struct ShimmerView<S: Shape>: View {
    var shape: S
    var shimmerColors: [Color] = [Color(#colorLiteral(red: 0.1058823529, green: 0.1137254902, blue: 0.1215686275, alpha: 1)), Color.white.opacity(0.2), Color(#colorLiteral(red: 0.1058823529, green: 0.1137254902, blue: 0.1215686275, alpha: 1))]
    var animationSpeed: Double = 0.5

    @State private var shimmerOffset: CGFloat = -1

    var body: some View {
        shape
            .fill(Color(#colorLiteral(red: 0.1058823529, green: 0.1137254902, blue: 0.1215686275, alpha: 1)))
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: shimmerColors),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .offset(x: shimmerOffset * 200)
                .clipShape(shape)
                .drawingGroup()
            )
            .onAppear {
                withAnimation(.linear(duration: animationSpeed).repeatForever(autoreverses: false)) {
                    shimmerOffset = 2
                }
            }
    }
}


#Preview {
    ShimmerView(shape: Rectangle()).frame(height: 50)
}
