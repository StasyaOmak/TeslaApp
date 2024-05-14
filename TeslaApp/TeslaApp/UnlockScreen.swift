//
//  UnlockScreen.swift
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
}


struct UnlockScreen: View {
    @State var isCarClose = false
    
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
    }
    
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
                    title: {Image(systemName: isCarClose ? "lock.open.fill" : "lock.fill")
                            .renderingMode(.template)
                            .tint(gradient)
                            .neumorphismUNSelectedCircle()
                            .neumorphismSelectedStyle()
                            .padding(.leading, 10)
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
            Text( isCarClose ? "Hi" : "")
                .font(.system(size: 20))
                .opacity(0.4)
            Text(isCarClose ? "Welcome back" : "")
                .fontWeight(.bold)
                .font(.title)
        }
        .position(x: UIScreen.main.bounds.width / 2, y: 100)
    }
    
    var settingButton: some View {
        Button(action: {
            
        }, label: {
            Image(systemName: "gearshape")
                .renderingMode(.template)
                .frame(height: 150)
                .tint(.gray)
                .neumorphismUNSelectedCircle()
                .neumorphismUnSelectedStyle()
        })
        .position(x: UIScreen.main.bounds.width - 50, y: 50)
    }
}

#Preview {
    UnlockScreen()
        .environment(\.colorScheme, .dark)
}
