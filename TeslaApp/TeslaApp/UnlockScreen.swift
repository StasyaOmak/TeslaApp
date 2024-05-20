//
//  UnlockScreen.swift
//  TeslaApp
//
//  Created by Anastasiya Omak on 14/05/2024.
//

import SwiftUI

struct UnlockScreen: View {
    @State var isCarClose = false
    @State private var showGreeting = false
    
    func backgroundStackView<Content: View>(content: () -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(isCarClose ? Color.background : Color.blackBackground)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            content()
        }
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                backgroundStackView {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            settingButton
                        }
                        .padding(.trailing)
                        greetingTitle
                            .padding(.bottom, 150)
                        carView
                        closeCarControlView
                        Spacer()
                    }
                    .padding(.bottom, 200)
                }
                .onChange(of: isCarClose) { newValue in
                    withAnimation {
                        showGreeting = newValue
                    }
                }
            }
        } else {
        }
    }
    
    @State var isShowMainTeslaView = false
    
    var gradient: LinearGradient {
        LinearGradient(colors: [.topDradient, .botomGradient], startPoint: .bottom, endPoint: .top)
    }
    
    var carView: some View {
        Image(isCarClose ? "lightTesla" : "tsla")
            .resizable()
            .frame(height: 300)
            .padding(.horizontal)
            .padding(.bottom, 40)
            .shadow(color: .black.opacity(0.6), radius: 15, x: 10, y: 10)
            .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 - 300)
    }
    
    var closeCarControlView: some View {
        Button {
            withAnimation {
                isCarClose.toggle()
            }
        } label: {
            HStack {
                Label(
                    title: {
                        if #available(iOS 16.0, *) {
                            Image(systemName: isCarClose ? "lock.open.fill" : "lock.fill")
                                .renderingMode(.template)
                                .tint(gradient)
                                .neumorphismUNSelectedCircle()
                                .neumorphismSelectedStyle()
                                .padding(.leading, 10)
                        } else {
                        }
                    },
                    icon: {
                        Text(isCarClose ? "Lock" : "Unlock")
                            .foregroundColor(.gray)
                            .fontWeight(.bold)
                            .font(.system(size: 15))
                    })
            }
            .frame(width: 120, height: 50)
            .padding()
            .background(RoundedRectangle(cornerRadius: 50).fill(Color("background")))
            .neumorphismSelectedStyle()
        }
        .position(x: UIScreen.main.bounds.width / 2, y: 150)
    }
    
    var greetingTitle: some View {
        VStack(spacing: 15) {
            if showGreeting {
                Text("Hi")
                    .font(.system(size: 20))
                    .opacity(0.4)
                    .transition(.opacity)
                Text("Welcome back")
                    .fontWeight(.bold)
                    .font(.title)
                    .transition(.opacity)
            }
        }
        .position(x: UIScreen.main.bounds.width / 2, y: 100)
    }
    
    var settingButton: some View {
        NavigationLink {
            MainTabView()
        } label: {
            Image(systemName: "gearshape")
                .renderingMode(.template)
                .frame(width: 50, height: 50)
                .tint(.gray)
                .neumorphismUNSelectedCircle()
                .neumorphismUnSelectedStyle()
        }
        .position(x: UIScreen.main.bounds.width - 70, y: 50)
    }
}


#Preview {
    UnlockScreen()
        .environment(\.colorScheme, .dark)
}
