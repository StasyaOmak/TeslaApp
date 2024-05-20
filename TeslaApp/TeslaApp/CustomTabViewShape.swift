//
//  CustomTabViewShape.swift
//  TeslaApp
//
//  Created by Anastasiya Omak on 17/05/2024.
//

import SwiftUI

struct CustomTabViewShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let height = rect.height
        
        path.move(to: CGPoint(x: rect.minX + 40, y: rect.maxY))
        
        path.addQuadCurve(to: CGPoint(x: 0, y: rect.midY + 5), control: CGPoint(x: rect.minX + 5, y: height - 15))
        
        path.addQuadCurve(to: CGPoint(x: rect.minX + 40, y: rect.minY + 2), control: CGPoint(x: rect.minX - 10, y: rect.minY + 20))
        
        path.addQuadCurve(to: CGPoint(x: rect.midX - 47, y: rect.minY + 20), control: CGPoint(x: rect.midX - 60, y: rect.minY + 5))

        path.addQuadCurve(to: CGPoint(x: rect.midX + 47, y: rect.minY + 20), control: CGPoint(x: rect.midX, y: rect.minY + 60))

        path.addQuadCurve(to: CGPoint(x: rect.maxX - 47, y: rect.minY + 2), control: CGPoint(x: rect.midX + 60, y: rect.minY + 5))

        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY + 5), control: CGPoint(x: rect.maxX + 10, y: rect.minY + 20))

        path.addQuadCurve(to: CGPoint(x: rect.maxX - 40, y: rect.maxY), control: CGPoint(x: rect.maxX - 5, y: rect.maxY - 15))

        return path
    }
}


