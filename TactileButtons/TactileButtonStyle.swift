//
//  TactileButtonStyle.swift
//  TactileButtons
//
//  Created by Wayne Dahlberg on 10/11/24.
//

import SwiftUI

// MARK: - Convenience extension

extension ButtonStyle where Self == TactileButtonStyle {
  static func tactile() -> Self {
    return TactileButtonStyle()
  }
}


// MARK: - Button style

struct TactileButtonStyle: ButtonStyle {
  let maxScaleReduction: CGFloat = 2 // Fixed 4 pixel reduction
  
  func makeBody(configuration: Configuration) -> some View {
    GeometryReader { geometry in
      ZStack {
        RoundedRectangle(cornerRadius: 10, style: .continuous)
          .inset(by: -5)
          .fill(configuration.isPressed
                ? Gradient(colors: [Color(hex: "#E9E9E9"), Color(hex: "#FFFFFF")])
                : Gradient(colors: [Color(hex: "#EAEAEA"), Color(hex: "#E9E9E9")]))
        
        
        // Non-scaling background shape
        RoundedRectangle(cornerRadius: 10)
          .inset(by: -0.5)
          .fill(configuration.isPressed
                ? Gradient(colors: [Color(hex: "#8E8E8E"), Color(hex: "#6E6E6E")])
                : Gradient(colors: [Color(hex: "#C6C6C6"), Color(hex: "#a4a4a4")]))
        
        // Scaling button background
        ZStack {
          RoundedRectangle(cornerRadius: configuration.isPressed ? 9 : 10, style: .continuous)
            .inset(by: 2.5)
            .fill(configuration.isPressed
                  ? Gradient(colors: [Color(hex: "#FEFEFE"), Color(hex: "#F4F4F4")])
                  : Gradient(colors: [Color(hex: "#F4F4F4"), Color(hex: "#FEFEFE")]))
            .shadow(color: configuration.isPressed ? .clear : .black.opacity(0.2), radius: 5, x: 0, y: 5)
            .shadow(color: configuration.isPressed ? .clear : .black.opacity(0.2), radius: 2, x: 0, y: 2)
          RoundedRectangle(cornerRadius: configuration.isPressed ? 9 : 10, style: .continuous)
            .inset(by: 2.5)
            .fill(.clear)
            .stroke(configuration.isPressed
                    ? Gradient(colors: [Color(hex: "#FEFEFE"), Color(hex: "#EDEDED")])
                    : Gradient(colors:[Color(hex: "#FFFFFF"), Color(hex: "#DCDCDC")]), lineWidth: 5)
        }
        .scaleEffect(
          calculateUniformScale(for: geometry.size, isPressed: configuration.isPressed),
          anchor: .center
        )
        
        // Non-scaling label
        configuration.label
          .font(.system(.headline, design: .rounded, weight: .semibold))
          .scaleEffect(configuration.isPressed ? 0.98 : 1)
          .foregroundColor(.black)
      }
      .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
  }
  
  private func calculateUniformScale(for size: CGSize, isPressed: Bool) -> CGSize {
    if !isPressed {
      return CGSize(width: 1, height: 1)
    }
    
    let widthScale = (size.width - maxScaleReduction) / size.width
    let heightScale = (size.height - maxScaleReduction) / size.height
    
    return CGSize(width: widthScale, height: heightScale)
  }
}
