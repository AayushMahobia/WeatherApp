//
//  RedactionModifires.swift
//  WeatherApp
//
//  Created by Admin on 30/01/25.
//

import Foundation

import SwiftUI

/// Adds a custom shimmer effect to any `View` when redacted, using a `ViewModifier`.
///
/// This extension allows you to apply a shimmer animation to any view to indicate a loading state.
/// The shimmer effect is configurable with optional parameters for opacity levels and shadow inclusion.
/// - Parameters:
///  - `isLoading`: A `Binding<Bool>` that controls whether the shimmer effect should be active or not.
///  - `opacityA`: The minimum opacity level for the shimmer animation. Defaults to `0.1`.
///  - `opacityB`: The maximum opacity level for the shimmer animation. Defaults to `1.0`.
///  - `isWithShadow`: A `Bool` indicating whether the shimmer effect should include a shadow. Defaults to `false`.
/// - Returns: A modified view that displays a shimmer effect when `isLoading` is `true`.
public extension View {
  func redactionShimmerViewModifier(
    isLoading: Binding<Bool>,
    opacityA: Double? = 0.1,
    opacityB: Double? = 1.0,
    isWithShadow: Bool? = false
  ) -> some View {
    return AnyView(
      self.modifier(
        Redaction(
          isLoading: isLoading,
          opacityA: opacityA,
          opacityB: opacityB,
          isWithShadow: isWithShadow,
          isWithShimmerEffect: true
        )
      )
    )
  }
}

/// A custom `ViewModifier` that applies redaction and shimmer effects to a view.
///
/// This modifier allows views to display placeholder effects with optional shimmer and shadow during loading states.
/// It supports configurable opacity levels, shadows, and a shimmering animation based on the `isLoading` binding.
struct Redaction: ViewModifier {
  @State var isOpacityAlternatingOnAppear = false
  @Binding var isLoading: Bool
  var opacityA: Double?
  var opacityB: Double?
  var isWithShadow: Bool?
  var isWithShimmerEffect: Bool?
   
  /// Initializes the `Redaction` modifier with customizable parameters.
  ///
  /// - Parameters:
  ///  - `isLoading`: A `Binding<Bool>` that controls the loading state of the view.
  ///  - `opacityA`: Optional minimum opacity during loading, defaults to `0.5`.
  ///  - `opacityB`: Optional maximum opacity during loading, defaults to `0.8`.
  ///  - `isWithShadow`: A flag that controls whether a shadow effect is applied during loading. Defaults to `false`.
  ///  - `isWithShimmerEffect`: A flag indicating whether the shimmering effect should be active. Defaults to `false`.
  init(isLoading: Binding<Bool>, opacityA: Double? = 0.5, opacityB: Double? = 0.8, isWithShadow: Bool? = false, isWithShimmerEffect: Bool? = false) {
    _isLoading = isLoading
    self.opacityA = opacityA
    self.opacityB = opacityB
    self.isWithShadow = isWithShadow
    self.isWithShimmerEffect = isWithShimmerEffect
  }
   
  /// Defines the body of the `Redaction` modifier, applying redaction, shimmer, and shadow effects.
  ///
  /// - Parameters:
  ///  - content: The original content of the view that is being modified.
  /// - Returns: A view modified with redaction, shimmer, and optional shadow effects based on the `isLoading` state.
  func body(content: Content) -> some View {
    if isWithShimmerEffect ?? false {
      content
        .shimmering(active: isLoading ? true : false)
        .shadow(radius: isWithShadow ?? false && isLoading ? 3 : 0)
        .redacted(reason: isLoading ? .placeholder : [])
    } else {
      content
        .shadow(radius: isWithShadow ?? false && isLoading ? 3 : 0)
        .redacted(reason: isLoading ? .placeholder : [])
        .opacity(isLoading ? (isOpacityAlternatingOnAppear && isLoading ? 0.5 : 0.8) : 1.0)
        .onAppear {
          withAnimation(.easeInOut(duration: 0.88).repeatForever()) {
            isOpacityAlternatingOnAppear.toggle()
          }
        }
    }
  }
}



