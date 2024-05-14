//
//  ClimateView.swift
//  TeslaApp
//
//  Created by Anastasiya Omak on 14/05/2024.
//

import SwiftUI

struct ClimateView: View {
    
    func backgroundStackView<Content: View>(content: () -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.background)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            content()
        }
    }
    
    var body: some View {
        NavigationView {
            backgroundStackView {
                HStack(spacing: 30) {
                    backButton
                    textLabel
                    settingButton
                }
                
            }
        }
        
    }
    
    var settingButton: some View {
        NavigationLink {
            MainTeslaView()
        } label: {
            Image(systemName: "gearshape")
                .renderingMode(.template)
                .frame(width: 50, height: 50)
                .tint(.gray)
                .neumorphismUNSelectedCircle()
                .neumorphismUnSelectedStyle()
        }
    }
    
    var backButton: some View {
        NavigationLink {
            MainTeslaView()
        } label: {
            Image(systemName: "chevron.left")
                .renderingMode(.template)
                .frame(width: 50, height: 50)
                .tint(.gray)
                .neumorphismUNSelectedCircle()
                .neumorphismUnSelectedStyle()
        }
   
        
    }
    
    var textLabel: some View {
        Text("CLIMATE")
            .fontWeight(.bold)
            .font(.title)
        
    }
    
//    var climateButton: some View {
//        DisclosureGroup {
//            
//            
//        }
//    }
    
}


#Preview {
    ClimateView()
        .environment(\.colorScheme, .dark)
}
