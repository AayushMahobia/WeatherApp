//
//  Shimmer.swift
//  WeatherApp
//
//  Created by Admin on 30/01/25.
//

import Foundation
import SwiftUI

public struct Shimmer: ViewModifier {
  private let animation: SwiftUI.Animation
  private let gradient: Gradient
  private let min, max: CGFloat
  @State private var isInitialState = true
  @Environment(\.layoutDirection) private var layoutDirection

  public init(
    animation: SwiftUI.Animation = Self.defaultAnimation,
    gradient: Gradient = Self.defaultGradient,
    bandSize: CGFloat = 0.3
  ) {
    self.animation = animation
    self.gradient = gradient
    self.min = 0 - bandSize
    self.max = 1 + bandSize
  }

  public static let defaultAnimation = SwiftUI.Animation.linear(duration: 0.75).delay(0.25).repeatForever(autoreverses: false)

  public static let defaultGradient = Gradient(colors: [
    .black.opacity(0.3),
    .black.opacity(0.4),
    .black.opacity(0.3)
  ])

  var startPoint: UnitPoint {
    if layoutDirection == .rightToLeft {
      return isInitialState ? UnitPoint(x: max, y: min) : UnitPoint(x: 0, y: 1)
    } else {
      return isInitialState ? UnitPoint(x: min, y: min) : UnitPoint(x: 1, y: 1)
    }
  }

  var endPoint: UnitPoint {
    if layoutDirection == .rightToLeft {
      return isInitialState ? UnitPoint(x: 1, y: 0) : UnitPoint(x: min, y: max)
    } else {
      return isInitialState ? UnitPoint(x: 0, y: 0) : UnitPoint(x: max, y: max)
    }
  }

  public func body(content: Content) -> some View {
    content
      .mask(LinearGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint))
      .onAppear {
        withAnimation(animation) {
          isInitialState = false
        }
      }
  }
}

public extension View {
  @ViewBuilder
  func shimmering(active: Bool = true, animation: SwiftUI.Animation = Shimmer.defaultAnimation, gradient: Gradient = Shimmer.defaultGradient, bandSize: CGFloat = 0.3) -> some View {
    if active {
      modifier(Shimmer(animation: animation, gradient: gradient, bandSize: bandSize))
    } else {
      self
    }
  }
}



