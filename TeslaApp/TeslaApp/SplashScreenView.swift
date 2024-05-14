//
//  SplashScreenView.swift
//  TeslaApp
//
//  Created by Anastasiya Omak on 14/05/2024.
//

import SwiftUI


import SwiftUI

struct TeslaIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        
        path.move(to: CGPoint(x: 0.5 * width, y: 0.22 * height))
        path.addLine(to: CGPoint(x: 0.60 * width, y: 0.09 * height))
        path.addCurve(to: CGPoint(x: 0.96 * width, y: 0.18 * height), control1: CGPoint(x: 0.60 * width, y: 0.1 * height), control2: CGPoint(x: 0.78 * width, y: 0.10 * height))
        path.addCurve(to: CGPoint(x: 0.82 * width, y: 0.28 * height), control1: CGPoint(x: 0.91 * width, y: 0.25 * height), control2: CGPoint(x: 0.82 * width, y: 0.28 * height))
        path.addCurve(to: CGPoint(x: 0.64 * width, y: 0.21 * height), control1: CGPoint(x: 0.81 * width, y: 0.22 * height), control2: CGPoint(x: 0.77 * width, y: 0.21 * height))
        path.addLine(to: CGPoint(x: 0.50 * width, y: 1.00 * height))
        path.addLine(to: CGPoint(x: 0.36 * width, y: 0.21 * height))
        path.addCurve(to: CGPoint(x: 0.18 * width, y: 0.28 * height), control1: CGPoint(x: 0.23 * width, y: 0.21 * height), control2: CGPoint(x: 0.18 * width, y: 0.22 * height))
        path.addCurve(to: CGPoint(x: 0.044 * width, y: 0.18 * height), control1: CGPoint(x: 0.18 * width, y: 0.28 * height), control2: CGPoint(x: 0.08 * width, y: 0.25 * height))
        path.addCurve(to: CGPoint(x: 0.40 * width, y: 0.09 * height), control1: CGPoint(x: 0.22 * width, y: 0.10 * height), control2: CGPoint(x: 0.40 * width, y: 0.09 * height))
        path.addLine(to: CGPoint(x: 0.50 * width, y: 0.23 * height))
        path.addLine(to: CGPoint(x: 0.50 * width, y: 0.22 * height))
        path.closeSubpath()
        
        
        path.move(to: CGPoint(x: rect.minX + 0.5 * rect.width, y: rect.minY + 0.06 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 0.97 * rect.width, y: rect.minY + 0.15 * rect.height), control1: CGPoint(x: rect.minX + 0.64 * rect.width, y: rect.minY + 0.06 * rect.height), control2: CGPoint(x: rect.minX + 0.80 * rect.width, y: rect.minY + 0.08 * rect.height))
        path.addCurve(to: CGPoint(x: rect.maxX, y: rect.minY + 0.09 * rect.height), control1: CGPoint(x: rect.minX + 0.99 * rect.width, y: rect.minY + 0.11 * rect.height), control2: CGPoint(x: rect.maxX, y: rect.minY + 0.09 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 0.5 * rect.width, y: rect.minY), control1: CGPoint(x: rect.minX + 0.81 * rect.width, y: rect.minY + 0.02 * rect.height), control2: CGPoint(x: rect.minX + 0.65 * rect.width, y: rect.minY + 0.00066 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.minY + 0.09 * rect.height), control1: CGPoint(x: rect.minX + 0.35 * rect.width, y: rect.minY + 0.00066 * rect.height), control2: CGPoint(x: rect.minX + 0.18 * rect.width, y: rect.minY + 0.02 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 0.03 * rect.width, y: rect.minY + 0.16 * rect.height), control1: CGPoint(x: rect.minX, y: rect.minY + 0.09 * rect.height), control2: CGPoint(x: rect.minX + 0.00813 * rect.width, y: rect.minY + 0.12 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 0.5 * rect.width, y: rect.minY + 0.06 * rect.height), control1: CGPoint(x: rect.minX + 0.19 * rect.width, y: rect.minY + 0.08 * rect.height), control2: CGPoint(x: rect.minX + 0.35 * rect.width, y: rect.minY + 0.06 * rect.height))
        path.closeSubpath()

        return path
    }
}

struct SplashScreenView: View {
    @State private var showUnlockScreen = false
    @State private var isBlur = true
    
    var body: some View {
          ZStack {
              TeslaIcon()
                  .tint(.white)
                  .frame(width: 300, height: 300)
                  .blur(radius: isBlur ? 10 : 0)
                  .scaleEffect(showUnlockScreen ? 1 : 0.5)
                  .animation(.easeInOut(duration: 1.5))
                  .opacity(showUnlockScreen ? 0 : 1)
                  .onAppear {
                      DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                          withAnimation {
                              isBlur = false
                          }
                      }
                      DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                          withAnimation {
                              showUnlockScreen = true
                          }
                      }
                  }

              if showUnlockScreen {
                  UnlockScreen()
              }
          }
          
          .background(Color.black.edgesIgnoringSafeArea(.all))
        
      }
  }

#Preview {
    SplashScreenView()
        .environment(\.colorScheme, .dark)
}
