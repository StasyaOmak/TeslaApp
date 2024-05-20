//
//  Neumorphism.swift
//  TeslaApp
//
//  Created by Anastasiya Omak on 14/05/2024.
//

import SwiftUI


struct NeumorphismUnSelected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .lightShadow, radius: 5, x: -5, y: -5)
            .shadow(color: .darkShadow, radius: 5, x: 5, y: 5)
    }
}

struct NeumorphismSelectedCircle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .background(Circle().fill(Color.background))
            .neumorphismUnSelectedStyle()
    }
}

struct NeumorphismSelected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .lightShadow, radius: 5, x: 5, y: 5)
            .shadow(color: .darkShadow, radius: 5, x: -5, y: -5)
    }
}

struct ClimateCircleSystemIndicatorModifaer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .lightShadow, radius: 5, x: -5, y: -5)
            .shadow(color: .darkShadow, radius: 5, x: 5, y: 5)
    }
    

}

extension View {
    func neumorphismUnSelectedStyle() -> some View {
        modifier(NeumorphismUnSelected())
    }
    
    func neumorphismSelectedStyle() -> some View {
        modifier(NeumorphismSelected())
    }
    
    func neumorphismUNSelectedCircle() -> some View {
        modifier(NeumorphismSelectedCircle())
    }
    
    func climateCircleSystemIndicator() -> some View {
        modifier(ClimateCircleSystemIndicatorModifaer())
    }
}
