//
//  MainTeslaView.swift
//  TeslaApp
//
//  Created by Anastasiya Omak on 14/05/2024.
//

import SwiftUI

var headerView: some View {
    HStack {
        VStack(alignment: .leading){
            Text("Tesla")
                .font(.system(size: 28))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text("187 km")
                .font(.system(size: 17))
                .fontWeight(.semibold)
                .opacity(0.4)
        }
        Spacer()
    }
    .padding(.all, 25)
}


struct MainTeslaView: View {

    func backgroundStackView<Content: View>(content: () -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.background)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            content()
            if tagSelected == 2 {
                       ClimateView()
                           .frame(maxWidth: .infinity, maxHeight: .infinity)
                           .background(Color.black.opacity(0.5))
                           .edgesIgnoringSafeArea(.all)
                   }
        }
    }
    var body: some View {
        backgroundStackView {
            VStack {
                headerView
                carView
                controlPanelView
                Spacer()
                    .frame(height: 40)
                if tagSelected == 1 {
                    closeCarControlView
                }
                Spacer()
            }
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingMainTesla = false
    @State var isCarClose = false
    @State var tagSelected = 0
    
    var carView: some View {
        Image(isCarClose ? "closeCar" : "car")
            .resizable()
            .frame(height: 200)
            .padding(.horizontal)
            .padding(.bottom, 40)
            .shadow(color: .white.opacity(0.6), radius: 15, x: 10, y: 10)
    }
    
    var gradient: LinearGradient {
        LinearGradient(colors: [.topDradient, .botomGradient], startPoint: .bottom, endPoint: .top)
    }

    var controlPanelView: some View {
        HStack(spacing: 30) {
            ForEach(1..<5) { index in
                Button {
                    withAnimation {
                        tagSelected = index
                    }
                } label: {
                    Image("\(index)")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .neumorphismUNSelectedCircle()
                        .overlay(Circle()
                            .stroke(gradient, lineWidth: 2)
                            .opacity(tagSelected == index ? 1 : 0)
                        )
                }
            }
            
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 50).fill(Color("background")))
        .neumorphismUnSelectedStyle()
    }
    
    var closeCarControlView: some View {
        Button {
            withAnimation {
                isCarClose.toggle()
            }
        } label: {
            HStack{
                Label {
                    Text(isCarClose ? "Закрыть" : "Открыть")
                            .foregroundColor(.white)
                    }
                    icon: { Image(systemName: isCarClose ? "lock.open.fill" : "lock.fill")
                            .renderingMode(.template)
                            .neumorphismUNSelectedCircle()
                            .neumorphismSelectedStyle()
                    }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 50).fill(Color("background")))
            .neumorphismSelectedStyle()
        }
        .frame(width: 300)
    }
}

#Preview {
    MainTeslaView()
        .environment(\.colorScheme, .dark)
}
