//
//  ChargeView.swift
//  TeslaApp
//
//  Created by Anastasiya Omak on 17/05/2024.
//

import SwiftUI
struct ChargeView: View {
    @State private var selectedTab = 0
    
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
            
                VStack {
                    HStack(spacing: 30) {
                        backButton
                        textLabel
                        settingButton
                    }
                    ZStack {
                        carView
                            .padding(.bottom, 110)
                        textView
                            .padding(.leading, 50)
                        battaryView
                            .padding(.top, 100)
                        
                    }
                    .padding()
                    boxView
                    .padding(.bottom, 200)
                    
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var settingButton: some View {
        Button {

        } label: {
            Image(systemName: "gearshape")
                .renderingMode(.template)
                .frame(width: 50, height: 50)
                .tint(.gray)
                .neumorphismUNSelectedCircle()
                .neumorphismUnSelectedStyle()
        }
        
    }
    
    var textView: some View {
            HStack {
                Text("75")
                    .bold()
                    .font(.title)
                    .foregroundStyle(.white)
                Text("%")
                    .bold()
                    .font(.title3)
                    .foregroundStyle(.gray)
        }
    }
    
    var backButton: some View {
        NavigationLink {
            MainTabView()
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
    
    var carView: some View {
        Image(.carCharge)
            .resizable()
            .frame(height: 200)
            .padding(.horizontal)
            .shadow(color: .white.opacity(0.6), radius: 15, x: 10, y: 10)
    }
    
    var battaryView: some View {
        Image(.battery)
            .resizable()
            .frame(height: 200)
            .padding(.horizontal)
            .shadow(color: .white.opacity(0.6), radius: 15, x: 10, y: 10)
    }
    
    private var boxView: some View {
        HStack {
            Text("Nearby Superchargers")
                .bold()
                .font(.title3)
            Spacer()
            Image(systemName: "chevron.compact.up")
                .renderingMode(.template)
                .frame(width: 50, height: 50)
                .tint(.gray)
                .neumorphismUNSelectedCircle()
                .neumorphismUnSelectedStyle()
        }
        .frame(width: 300, height: 100)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 10)
                .blur(radius: 10)
                .mask(
                    RoundedRectangle(cornerRadius: 40)
                        .fill(
                            LinearGradient(colors: [.darkShadow, .clear], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 40)
                .stroke(.white.opacity(0.11), lineWidth: 8)
                .blur(radius: 4)
                .offset(x: -5, y: -2)
                .mask(
                    RoundedRectangle(cornerRadius: 40)
                        .fill(
                            LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                        )
                )
        )
    }
}

#Preview {
    ChargeView()
        .environment(\.colorScheme, .dark)
}

